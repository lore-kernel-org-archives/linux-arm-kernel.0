Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA8C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858652082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HgWKJBC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858652082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CnehGrp58rZbPWAvEZZhfGDYvmBPuK4CcyAjfDXT7GM=; b=HgWKJBC5AJwDcP
	ecqWEp0PqnxStDe+eu+/3ZjN8URAJJ4aVR4kjlPV7n5ySqY/QIa8M/DRjPgrez8pYuvEmfOmv0sF9
	eHP0O9oyz/vOrcJuRHi0qDOW4cJSzEdP+ckzcFWcCLiStyheNIIhYJWjV6Qw9DTm0YCLrNejdpYxW
	Ad5z1ebOPtbILSJ4sbMO2fxrGC1qmGkwPQtWLk59BYAxy0Kwkjr9zePbwdQYBGZj3W3Am2AYTk1sK
	42W2pKKCGRYQjljkLO4GjH1d4DuXJf2Z9VpFa3LPSb1ZX0yVofGVP1PGS5MZyW0db6rqIV8lsYpuh
	Fu/ZzucyJSR5ftGRpCUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWO7N-0003IY-7o; Mon, 10 Dec 2018 16:09:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWO7J-0003HS-Qf
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:09:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4E701596;
 Mon, 10 Dec 2018 08:08:58 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34393F6A8;
 Mon, 10 Dec 2018 08:08:57 -0800 (PST)
Subject: Re: [PATCH 00/12] arm64: Paravirtualized time support
To: Mark Rutland <mark.rutland@arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181210114047.tifwh6ilwzphsbqy@lakrids.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <3a859c39-572f-450e-5e43-d0cab54048ac@arm.com>
Date: Mon, 10 Dec 2018 16:08:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210114047.tifwh6ilwzphsbqy@lakrids.cambridge.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_080909_871714_185D5271 
X-CRM114-Status: GOOD (  30.17  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/12/2018 11:40, Mark Rutland wrote:
> On Wed, Nov 28, 2018 at 02:45:15PM +0000, Steven Price wrote:
>> This series add support for paravirtualized time for Arm64 guests and
>> KVM hosts following the specification in Arm's document DEN 0057A:
>>
>> https://developer.arm.com/docs/den0057/a
>>
>> It implements support for Live Physical Time (LPT) which provides the
>> guest with a method to derive a stable counter of time during which the
>> guest is executing even when the guest is being migrated between hosts
>> with different physical counter frequencies.
>>
>> It also implements support for stolen time, allowing the guest to
>> identify time when it is forcibly not executing.
> 
> I know that stolen time reporting is important, and I think that we
> definitely want to pick up that part of the spec (once it is published
> in some non-draft form).
> 
> However, I am very concerned with the pv-freq part of LPT, and I'd like
> to avoid that if at all possible. I say that because:
> 
> * By design, it breaks architectural guarantees from the PoV of SW in
>   the guest.
> 
>   A VM may host multiple SW agents serially (e.g. when booting, or
>   across kexec), or concurrently (e.g. Linux w/ EFI runtime services),
>   and the host has no way to tell whether all software in the guest will
>   function correctly. Due to this, it's not possible to have a guest
>   opt-in to the architecturally-broken timekeeping.
> 
>   Existing guests will not work correctly once pv-freq is in use, and if
>   configured without pv-freq (or if the guest fails to discover pv-freq
>   for any reason), the administrator may encounter anything between
>   subtle breakage or fatally incorrect timekeeping.
> 
>   There's plenty of SW agents other than Linux which runs in a guest,
>   which would need to be updated to handle pv-freq, e.g. GRUB, *BSD,
>   iPXE.
> 
>   Given this, I think that this is going to lead to subtle breakage in
>   real-world scenarios. 

LPT only changes things on migration. Up until migration the
(architectural) clocks still behave perfectly normally. A guest which
opts in to LPT can derive a clock with a different frequency, but the
underlying clock doesn't change.

When migration happens it's a different story.

If the frequency of the new host matches the old host then again the
clocks behave 'normally': CNTVOFF is used to hide the change in offset
such that the guest at worst sees time pause during the actual migration.

But the whole point of LPT is to deal with the situation if the clock
frequency has changed. A guest (or SW agent) which doesn't know about PV
will experience one of two things:

* Without LPT: the clock frequency will suddenly change without warning,
but the virtual counter is monotonically increasing.

* With LPT: the clock frequency will suddenly change and the virtual
counter will jump (it won't be monotonically increasing).

So I agree the situation with LPT is worse (we lose the monotonicity),
but any guest/agent which didn't understand about the migration is in
trouble if it cares about time.

> * It is (necessarily) invasive to the low-level arch timer code. This is
>   unfortunate, and I strongly suspect this is going to be an area with
>   long-term subtle breakage.

I can't argue against that - I've tried to limit how invasive the code
changes are, but ultimately we're changing the interpretation of
low-level timers.

> * It's not clear to me how strongly people need this. My understanding
>   is that datacenters would run largely homogeneous platforms. I suspect
>   large datacenters which would use migration are in a position to
>   mandate a standard timer frequency from their OEMs or SiPs.
> 
>   I strongly believe that an architectural fix (e.g. in-hw scaling)
>   would be the better solution.

An architectural fix in hardware is clearly the best solution. The
question is whether we want to support the use-case with today's
hardware. While mandating a particular 'standard' timer frequency is a
good idea, there's currently no standard. Large datacenters might be
able to mandate that, and maybe there'll be sufficient consensus that
this doesn't matter. But I seem to have misplaced my crystal ball...

> I understand that LPT is supposed to account for time lost during the
> migration. Can we account for this without pv-freq? e.g. is it possible
> to account for this in the same way as stolen time?

LPT isn't really about accounting for the time lost (to some extent this
is already done by saving/restoring the "KVM_REG_ARM_TIMER_CNT"
register) but about ensuring that the guest can derive a monotonically
increasing counter which maintains a stable frequency when migrated.

I'm going to respin the series with the LPT parts split out to the end,
that way we can (hopefully) agree on the stolen time parts and can defer
the LPT part if necessary.

Thanks,

Steve

> Thanks,
> Mark.
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
