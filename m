Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9C7206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TllxdraG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2wPt5bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9C7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FvktZzPzoLo0ngeH0Nfv+WrZIOhGZoZh4RUdf+f03hY=; b=TllxdraGJY23qR
	hqF8ZNRGWs8R4lrww7eck1w2a3shVmOQhkIbMjMQNLeJ2YcJfL0i/Dhjtu007cW27YpRjBPHj0HGe
	ipbUkqDTBs33RAjr9bVohT7OnXdVItSYdTg98EiNkJ4Z/Ar1zp4oUvj/V422/Xrrup2w5TGFvxIvj
	Gl++JCNKWV/mkXOCdlyHNI0LA7t+cyhB/0+ercB4Tx2k6ka33886mGAsAwvG7HxF/k5IR/F20GKqL
	ZIlKJSFCcrkxVPBTCj0wllmCtWnDk98yY/HR5HakP5zY9ssYzKbkFFbM2yfBKKMysdH+sWD1XFiFZ
	P848IwJ+6T85t80XzfHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoXk-0008Bc-4T; Fri, 14 Dec 2018 14:34:20 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoXg-0008AI-Eq
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:18 +0000
Received: by mail-oi1-x243.google.com with SMTP id m6so4669423oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FMgXFm/rRO6gaes71rbchB5oOTyNj1IYboe7Uczq2eU=;
 b=V2wPt5bUwXqnvzs31xGj2MrPI+XxhIUzteHmi6Oqb60Y0tTQY4Cbzxj+KVvzFxkklM
 eNNrxoWQYUYRuJw5i3zPl8KJfiJ1oYW7CFbIEMcdd5n7rQ6odxGaL6eVnULBVaS0hVp1
 wzqwncglY2NjV+LYVflwHi2Fcf7tONEDeNnDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FMgXFm/rRO6gaes71rbchB5oOTyNj1IYboe7Uczq2eU=;
 b=sPdAnVniEvWNWZbGxP8lmkbWZMKqdUQRGk2AOeLEUpJJDkWNLm5d68vYNs3VHPe4OM
 8o+Vz7E59jsUeTILftzWPBScWbCdXDHPRibkoP3m3wdWyKPCOo2KMKLiNFvwvZ4OzLiR
 HK9c0g0qIb6L2/lOC5Hx0oJc4/HZ+5CAbNKmmToQfgfyoMqjsYDFnRfrEtX3DaZyNtEy
 eADbmA3hbkJJBm9NakIFTQK+8Nz1TGiWzFQ/0I9bg++UjV1hxVtHsGSjUCsgMxwpPp/I
 JakfteMahKtejsmlV9X5cmtO9s+zk2fgB8QByUVLr296PJvvgolfAAJgphgeTwlLU75N
 dSBw==
X-Gm-Message-State: AA+aEWYBNvYKeHeoxrveQA2CERMjPMoPtV4lYXm5GizvqCf5aIXTzF17
 tg3yGpYqYciElu75QJm44HitzfzvN0/N7e8JwBsp9A==
X-Google-Smtp-Source: AFSGD/VEtBNKjE0LtLP8dvRnqOk+rnG/1YhJtF32Sp5qGNQxxKCTyYCTDd7v15itBfj8DgVQqyyEC9U658f38RS9lxM=
X-Received: by 2002:aca:bcc6:: with SMTP id m189mr1951162oif.337.1544798045123; 
 Fri, 14 Dec 2018 06:34:05 -0800 (PST)
MIME-Version: 1.0
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
 <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
In-Reply-To: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:33:53 +0000
Message-ID: <CAFEAcA-ajJ_W0FtC00aEiG=wGgbbU_8OEt+B+B87647gTsSMvQ@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063416_493473_A27B1F99 
X-CRM114-Status: GOOD (  18.37  )
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

On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
>
> Hi Dongjiu Geng,
>
> On 14/12/2018 10:15, Dongjiu Geng wrote:
> > When user space do memory recovery, it will check whether KVM and
> > guest support the error recovery, only when both of them support,
> > user space will do the error recovery. This patch exports this
> > capability of KVM to user space.
>
> I can understand user-space only wanting to do the work if host and guest
> support the feature. But 'error recovery' isn't a KVM feature, its a Linux
> kernel feature.
>
> KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
> map a page at stage2 that the kernel-mm code refuses this because its poisoned.
> (e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)
>
> This is exactly the same as happens to a normal user-space process.
>
> I think you really want to know if the host kernel was built with
> CONFIG_MEMORY_FAILURE.

Does userspace need to care about that? Presumably if the host kernel
wasn't built with that support then it will simply never deliver
any memory failure events to QEMU, which is fine.

The point I was trying to make in the email Dongjiu references
(https://patchwork.codeaurora.org/patch/652261/) is simply that
"QEMU gets memory-failure notifications from the host kernel"
does not imply "the guest is prepared to receive memory
failure notifications", and so the code path which handles
the SIGBUS must do some kind of check for whether the guest
CPU is a type which expects them and that the board code
set up the ACPI tables that it wants to fill in.

thanks
-- PMM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
