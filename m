Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16866C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BE02147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XIJq3hiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BE02147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vm6S/oUMBfcNifnPpKi41ufa9BT94E7pJxPaI1FFEkM=; b=XIJq3hiO6qoELT
	8TuGXyFpUxNmM3VhgNTMTdJKpL4bFtUk+iB5RhSq03l0nYwrTV1p0aHWdchRDUnpmZEdHK53/M2Pm
	9RaSFlMiR2UtdlJykAm0SdQX/GY34y6LZcGk24wxBNRVoVjw+zhZs/FEUy71ES9qtrbb0Qkmn08Hg
	ki4RGatzjF4BkrFGj4Yp183dC7//0UHVl2WbknpavOV35cV+/kvKQvPDYobk/6xEjw1FnhALv4ecI
	l3abHgxmGT7c+RrRL8HlbGzy2j0zLjkIMQTr0XdlqrcmUhE1hFmh9k68iiaYpc1JwwgP8nH3cSRHd
	zqOoBksC3ge5r9E89jhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPSi-0003OT-6X; Wed, 20 Feb 2019 10:50:48 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPSd-0003KM-SV
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 10:50:45 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gwPSV-0005i0-6G; Wed, 20 Feb 2019 11:50:35 +0100
Date: Wed, 20 Feb 2019 11:50:35 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Message-ID: <20190220105034.7fv7u7lel4siu6zr@linutronix.de>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <VI1PR0702MB3840A772914621B2F026B349E4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840A772914621B2F026B349E4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_025044_065981_4EBE3CC4 
X-CRM114-Status: GOOD (  19.07  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yadi.hu@windriver.com" <yadi.hu@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-15 21:57:56 [+0000], Bernd Edlinger wrote:
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 58f69fa07df95..da82967865836 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -161,8 +161,6 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >  		unsigned int fsr, unsigned int sig, int code,
> >  		struct pt_regs *regs)
> >  {
> > -	if (addr > TASK_SIZE)
> > -		harden_branch_predictor();
> >  
> >  #ifdef CONFIG_DEBUG_USER
> >  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
> > @@ -191,6 +189,11 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  	struct task_struct *tsk = current;
> >  	struct mm_struct *mm = tsk->active_mm;
> >  
> > +	if (addr > TASK_SIZE && user_mode(regs))
> > +		harden_branch_predictor();
> 
> This is somehow inconsisten with do_translation_fault, where
> we have this:
> 
> 	if (addr < TASK_SIZE)
> 		return do_page_fault(addr, fsr, regs);

yes but harden_branch_predictor() is only invoked for addr > TASK_SIZE.
What do I miss?

> > +
> > +	if (interrupts_enabled(regs))
> > +		local_irq_enable();
> >  	/*
> >  	 * If we are in kernel mode at this point, we
> >  	 * have no context to handle this fault with.
> > 
> 
> I have seen three different failure modes, pleas see the first 3 calls stacks
> here: https://marc.info/?l=linux-rt-users&m=155016888714927&w=2

yes, but this is only with the one patch in RT. So you should not see
this without the RT patch.

> I am concerned about this fist issue, because it removes the branch
> predictor hardening after the do_page_fault has executed:
> 
> do_DataAbort->do_page_fault(addr>TASK_SIZE)->__do_user_fault
>
> This is reachable because do_page_fault is not only called from
> do_translation_fault but also from here: arch/arm/mm/fsr-2level.c
> and here: arch/arm/mm/fsr-3level.c
> those are callable with addr > TASK_SIZE

okay. So 0xbffffff0 without LPAE would be left out. I wasn't ware of
that. And this indeed it hits the warning.

> And the following code path does enable the hard irqs before do_bad_area:
> do_DataAbort->do_sect_fault->do_bad_area->__do_user_fault
> 
> So this function, would need to be rewritten:
> 
> do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> {
> 	if (interrupts_enabled(regs))
> 		local_irq_enable();
> 
> 	do_bad_area(addr, fsr, regs);
> 	return 0;
> }

We would need to move the branch predictor piece before enabling
interrupts.

> 
> Thanks
> Bernd.

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
