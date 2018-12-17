Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1EEB2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OaLLXp7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EEB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MGa+fYSorCxUXt1BDtqSon6PnzREXIOilnX+Y+FgdFA=; b=OaLLXp7awQvUF7
	xP6IpvuTOzv8gGrATSbK5ZECcgWfvVs46P8V4SGcb9bQ7Lv2E/9izVPFRJ1G5YQNYnEKS4gt4A9lm
	Kh4o+aDwsbH4AsWKtYd3nOgR42QpE/W78Dz0/rwvjNmUrot18Z9evNlolCtPWCPPGsSJSFpSO1SBL
	+oqgO48gfhaHBS5VHXUa8kQun0JmljYMxv6DfRyvGmbnq/NwMGzT0x8Er2h8Vimx/5Oz/bRLAAm/H
	a2T7cgJ8laYdXE0tukk+sBJ0nwhq6rOk0BfqxM7pvBxvIYNfzVR+3mH5dh5OxuI8vfNvUugJkpRhr
	Sb1x+O2uU1Ga/CKcNTJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvFo-0000SP-8s; Mon, 17 Dec 2018 15:56:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvFY-0000EL-3I
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:56:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C8D15AD;
 Mon, 17 Dec 2018 07:55:56 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502083F575;
 Mon, 17 Dec 2018 07:55:54 -0800 (PST)
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: Peter Maydell <peter.maydell@linaro.org>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
 <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
 <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1c532d67-104e-2c26-9cf9-289188a1f8b1@arm.com>
Date: Mon, 17 Dec 2018 15:55:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_075608_157837_D239B065 
X-CRM114-Status: GOOD (  25.48  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 kvm-devel <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 gengdongjiu <gengdongjiu@huawei.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Peter,

On 14/12/2018 14:33, Peter Maydell wrote:
> On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
>> On 14/12/2018 10:15, Dongjiu Geng wrote:
>>> When user space do memory recovery, it will check whether KVM and
>>> guest support the error recovery, only when both of them support,
>>> user space will do the error recovery. This patch exports this
>>> capability of KVM to user space.
>>
>> I can understand user-space only wanting to do the work if host and guest
>> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
>> kernel feature.
>>
>> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
>> map a page at stage2 that the kernel-mm code refuses this because its poisoned.
>> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>>
>> This is exactly the same as happens to a normal user-space process.
>>
>> I think you really want to know if the host kernel was built with
>> CONFIG_MEMORY_FAILURE.
> 
> Does userspace need to care about that? Presumably if the host kernel
> wasn't built with that support then it will simply never deliver
> any memory failure events to QEMU, which is fine.

Aha, I thought this is what you wanted.
Always being prepared to handle the signals is the best choice.


> The point I was trying to make in the email Dongjiu references
> (https://patchwork.codeaurora.org/patch/652261/) is simply that
> "QEMU gets memory-failure notifications from the host kernel"
> does not imply "the guest is prepared to receive memory
> failure notifications", and so the code path which handles
> the SIGBUS must do some kind of check for whether the guest

> CPU is a type which expects them

I don't understand this bit.

The CPU support is just about barriers for containment and reporting a
standardised classification to software. Firmware-first replaces all this. It
doesn't depend on any CPU feature.
APM-X-Gene has firmware-first support, it uses some kind of external processor
that takes the error-interrupt from DRAM and generates CPER records, before
triggering the firmware-first notification.

> and that the board code
> set up the ACPI tables that it wants to fill in.
ACPI has some complex stuff around claiming 'platform-wide capabilities'. Qemu
could use this to know if the guest understands APEI.

Section 6.2.11.2 "Platform-Wide OSPM Capabilities" of ACPI v6.2 describes the
\_SB._OSC method, which has an APEI support bit. This is used in some kind of
handshake.

Linux does this during boot if its built with APEI GHES support. Linux seems to
think the APEI bit enables firmware-first:
| [   63.804907] GHES: APEI firmware first mode is enabled by APEI bit.

... but its not clear from the spec. (APEI is more than firmware-first)

(where do these things go? Platform AML in the DSDT)


I don't think this controls anything on a real system, (we've seen X-Gene
generate CPER records before Linux started booting), and I don't think it really
matters as 'what happens if the guest doesn't know' falls out of the way these
SIGBUS codes map back onto the firmware-first notifications:

For 'AO' signals you can dump CPER records in a NOTIFY_POLLed area. If the guest
doesn't care, it can avert is eyes. If you used one of the NOTIFY_$(interrupt)
types, the guest can not-register the interrupt.

The AR signals map to external-abort. On a firmware-first system EL3 takes
these, generates some extra metadata using CPER records in the agreed location,
and re-injects an emulated external-abort.
If Qemu takes an AR signal, this is effectively an external-abort, the page has
been accessed and the kernel will not map it because the page is poisoned. These
would have been an external-abort on a real system, its not a problem if the
guest doesn't know about the extra CPER metadata.

Centriq is an example of a system that does this external-abort+CPER-metadata
without the v8.2 CPU extensions.

All v8.0 CPUs have synchronous/asynchronous external abort, there is nothing new
going on here, its just extra metadata. (critically: the physical address of the
fault)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
