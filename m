Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37022C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:35:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C84222E6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 11:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMiNOkzY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C1hYMOBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C84222E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vovz27lc2BYK/D52DNm5dzNvOqYlBbf7QC9knUP+24E=; b=pMiNOkzYWcDRXi
	QOz8GGGWWmM4vdvImtEXyCi5ZJFQzJv/pmFzaGXoMDmIB28y4PXo04/F4XHTYxCUmQ5UdJk//gD4E
	CerOBwxjNhu3NZvv2VxKWT+b06gS67qbtsaYSZenRH9gQrOMEV6G6qWuXwnH6HSsoYzlbD9OshAr3
	s/ecILrh+wyjPt4gfk8MG5vL+f358JMLBjV4UsNWsLPRDRDbJWJ0+1F7Bh4wJ3+QAPIUGVui6knsQ
	fZBnCGcElgpFWu8RUYpXkYW+IgDzHsmcgY+bAtMwE831LSVOc3dijKeUO9zkgsQr/aZRAk0qd/H8I
	OH2E4hwTVU2t4sdivz3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guyG8-0006XQ-3I; Sat, 16 Feb 2019 11:35:52 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guyG4-0004w2-Fl
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 11:35:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OxWDpiB+x2iMPx0aF+GBisAKjgEiReJM2U2KdV6KGnU=; b=C1hYMOByqvTPQu77z4bBe9CnF
 9HIHOzmVJAJtsLheP8Ua0FbXaggFDKKQK+n7NlKACGAbDyDRbiGeDKZ9EFjeIFlmAhvBcJhXAoY8Q
 5+MEejoXkEwp87oMq7VbjJrksHlJ/45P0h6WG7SJ/A1f5HGkFkXQMsPeyYiz+N0yR8FdHWJHm4vO8
 8hO4LPGUkrxyPWIKrLzOpPfJHX3HF9eRfLGafFBP8j8C/GddYMc/rcalcka1NOfpTXepryzy+iBz6
 rYjU8QJcxPB15ISCM1cFJtMDR/bIFPlcadL5b6XSDv/XSL792EIS/tw54y9ZMrVsndhooqK1CcOyU
 2CIwgO2zw==;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36810)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1guyE1-0001Oz-N3; Sat, 16 Feb 2019 11:33:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1guyDy-0005OT-QG; Sat, 16 Feb 2019 11:33:38 +0000
Date: Sat, 16 Feb 2019 11:33:38 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Message-ID: <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_033548_686119_D0BE2A1A 
X-CRM114-Status: GOOD (  22.24  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Bernd Edlinger <bernd.edlinger@hotmail.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, yadi.hu@windriver.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 09:05:33PM +0100, Sebastian Andrzej Siewior wrote:
> From: "Yadi.hu" <yadi.hu@windriver.com>
> 
> Accessing a kernel address in user space causes a SIGSEGV which is sent
> via
> -> do_DataAbort
>    -> do_sect_fault || do_translation_fault
>       -> do_bad_area
>          -> __do_user_fault
>             -> force_sig_fault
> Since commit
> 
>   02fe2845d6a83 ("ARM: entry: avoid enabling interrupts in prefetch/data abort handlers")
> 
> that path is carried out with disabled interrupts. Page/alignment fault
> do enable interrupts but data abort has been left out.
> 
> On -RT the siglock is a sleeping spinlock and requires interrupts to be
> enabled in order to acquire it.
> 
> Enable interrupts in the DataAbort handler if the parent context had
> interrupts enabled. Move harden_branch_predictor() before interrupts are
> enabled.

One very very big NAK.

You haven't given any reasoning for moving harden_branch_predictor().

Moving it in this way, you are re-opening systems up for branch
predictor attacks, since there is now a path through the data abort
handler where userspace can attempt to access kernel space, resulting
in a fault being generated, but the branch predictor hardening is no
longer called.

> Reported-by: <Bernd Edlinger <bernd.edlinger@hotmail.de>
> Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
> [bigeasy: rewrote patch description, reordered patch]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I though that the "interrupt enable part" has already been posted and
> then Bernd complained about a warning from harden_branch_predictor() on
> -RT so here it is.
> 
>  arch/arm/mm/fault.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 58f69fa07df95..da82967865836 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -161,8 +161,6 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>  		unsigned int fsr, unsigned int sig, int code,
>  		struct pt_regs *regs)
>  {
> -	if (addr > TASK_SIZE)
> -		harden_branch_predictor();
>  
>  #ifdef CONFIG_DEBUG_USER
>  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
> @@ -191,6 +189,11 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	struct task_struct *tsk = current;
>  	struct mm_struct *mm = tsk->active_mm;
>  
> +	if (addr > TASK_SIZE && user_mode(regs))
> +		harden_branch_predictor();
> +
> +	if (interrupts_enabled(regs))
> +		local_irq_enable();
>  	/*
>  	 * If we are in kernel mode at this point, we
>  	 * have no context to handle this fault with.
> -- 
> 2.20.1
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
