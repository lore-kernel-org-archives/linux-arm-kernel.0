Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:36:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBBA20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A5h3XFyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBBA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1o8i5OgFinwKB+42yTvTsZn9qHuwIZxcGnVftCaZs2k=; b=A5h3XFyTx/BAfW
	G2FIEv16DXcridwi+pdkJ4++IcbblshRuRipVWcagVqIeLP98Vb8Xa+EsuUGMAgx7Wpfvko3qzN5B
	xJDsBiMdKZBK0zxeIo3xMuO2zJUgdjs3CMNCrXSmn+GexgptFs0Z4UX75L2gPvqat+GBg1nOUq4ul
	csiYF8jFtbW9uMk/9xmSvVA4lxytu77godIXDqlPnslyJbk1RevIzHdqcf7GkOUowahPxMOvNOhCY
	jokP0czoQrq1g4MfaWhf9TPcv16+0WVoyvIi+uWTVlJ3HbCQchurpr+JtSLzRdsPDsgJ8tZYt/WWy
	qDaCvZte8FEJzkA1QPfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggokV-000428-MW; Tue, 08 Jan 2019 10:36:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggokS-00041h-Uc
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 10:36:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 754D2EBD;
 Tue,  8 Jan 2019 02:36:39 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CD233F6CF;
 Tue,  8 Jan 2019 02:36:38 -0800 (PST)
Date: Tue, 8 Jan 2019 11:36:37 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 00/12] arm64: Paravirtualized time support
Message-ID: <20190108103637.GI10769@e113682-lin.lund.arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181210114047.tifwh6ilwzphsbqy@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210114047.tifwh6ilwzphsbqy@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_023640_998822_1937D390 
X-CRM114-Status: GOOD (  22.27  )
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
 Steven Price <steven.price@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 11:40:47AM +0000, Mark Rutland wrote:
> On Wed, Nov 28, 2018 at 02:45:15PM +0000, Steven Price wrote:
> > This series add support for paravirtualized time for Arm64 guests and
> > KVM hosts following the specification in Arm's document DEN 0057A:
> > 
> > https://developer.arm.com/docs/den0057/a
> > 
> > It implements support for Live Physical Time (LPT) which provides the
> > guest with a method to derive a stable counter of time during which the
> > guest is executing even when the guest is being migrated between hosts
> > with different physical counter frequencies.
> > 
> > It also implements support for stolen time, allowing the guest to
> > identify time when it is forcibly not executing.
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

Is this necessarily true?

As I understood the intention of the spec, there would be no change to
behavior of the timers as exposed by the hypervisor unless a software
agent specifically ops-int to LPT and pv-freq.

In a scenario with Linux and UEFI running, they must clearly agree on
using functionality that changes the underlying behavior.  For
kdump/kexec scenarios, the OS would have to tear down the functionality
to work across migration after loading a secondary SW agent, which
probably needs adding to the spec.

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

I think we'd definitely need to limit the exposure of pv-freq to Linux
and (if necessary) UEFI runtime services.  Do you see scenarios where
this would not be possible?


[...]

> 
> I understand that LPT is supposed to account for time lost during the
> migration. Can we account for this without pv-freq? e.g. is it possible
> to account for this in the same way as stolen time?
> 

I think we can indeed account for lost time during migration or host
system suspend by simply adjusting CNTVOFF_EL2 (as Steve points out, KVM
already supports this, but QEMU doesn't make use of that today -- there
were some patches attempting to address that recently).


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
