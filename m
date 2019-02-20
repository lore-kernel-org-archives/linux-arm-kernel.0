Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D16C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C4020685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/l1xM4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C4020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kZ3avk/GXd0h6TCAo+m7UI1csvXr52y76GallUwxDig=; b=G/l1xM4pil/jMH
	RVjLktuxXzSSx4auYDT/6vrem+TAxFlnoaj33zXieBxKiWCSzRA8fN4uCyaG6msEnWwqeAV3dqGDq
	cIAvf3MiZhbECS21q7G539mH+THtkZ6PrheZhFylGFbteJwzo2MS2wMAy3teKVHngROzPkNEAd7/F
	jxH3M+9XML2CQimzXaKVCg7rTj2GF0Wh+JghbSs9kQrfCWwXo3hNGkLry/lWFeZ9n8npnY6TfYVQe
	XUhhXQLpTygpopSBw7O7TL1ni2CR3nfIXVx530hiphZTYvyDd8GTIuMNDNcUIt3EIXHrg9iA5qXK4
	P3vJSjUO/HN/mlIqn+kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPcO-00082C-BM; Wed, 20 Feb 2019 11:00:48 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPcJ-0007wP-2x
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:00:45 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gwPcF-00060p-JC; Wed, 20 Feb 2019 12:00:39 +0100
Date: Wed, 20 Feb 2019 12:00:39 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Message-ID: <20190220110039.2p2iglhqlf6xapsb@linutronix.de>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_030043_342601_D73BF771 
X-CRM114-Status: GOOD (  15.39  )
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

On 2019-02-16 11:33:38 [+0000], Russell King - ARM Linux admin wrote:
> On Fri, Feb 15, 2019 at 09:05:33PM +0100, Sebastian Andrzej Siewior wrote:
> > From: "Yadi.hu" <yadi.hu@windriver.com>
> > 
> > Accessing a kernel address in user space causes a SIGSEGV which is sent
> > via
> > -> do_DataAbort
> >    -> do_sect_fault || do_translation_fault
> >       -> do_bad_area
> >          -> __do_user_fault
> >             -> force_sig_fault
> > Since commit
> > 
> >   02fe2845d6a83 ("ARM: entry: avoid enabling interrupts in prefetch/data abort handlers")
> > 
> > that path is carried out with disabled interrupts. Page/alignment fault
> > do enable interrupts but data abort has been left out.
> > 
> > On -RT the siglock is a sleeping spinlock and requires interrupts to be
> > enabled in order to acquire it.
> > 
> > Enable interrupts in the DataAbort handler if the parent context had
> > interrupts enabled. Move harden_branch_predictor() before interrupts are
> > enabled.
> 
> One very very big NAK.
> 
> You haven't given any reasoning for moving harden_branch_predictor().

if do_bad_area() opens interrupts then harden_branch_predictor() will
complain via smp_processor_id(). So it looked obvious to move
harden_branch_predictor() before interrupts are enabled.

> Moving it in this way, you are re-opening systems up for branch
> predictor attacks, since there is now a path through the data abort
> handler where userspace can attempt to access kernel space, resulting
> in a fault being generated, but the branch predictor hardening is no
> longer called.

Bernd Edlinger explained the missing piece to me. With
PAGE_OFFSET=0xC0000000 and without LPAE a R/W of 0xbffffff0 will ends up
with:

| ~/mem-tc 0xbffffff0 1
|Write 0xbffffff0
|BUG: using smp_processor_id() in preemptible [00000000] code: mem-tc/706
|caller is __do_user_fault.constprop.2+0x78/0xa4
|CPU: 3 PID: 706 Comm: mem-tc Tainted: G        W         5.0.0-rc6-00001-g625f719a23bda-dirty #35
|Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
|[<c01123d4>] (unwind_backtrace) from [<c010cc58>] (show_stack+0x10/0x14)
|[<c010cc58>] (show_stack) from [<c0a40988>] (dump_stack+0x78/0x8c)
|[<c0a40988>] (dump_stack) from [<c045427c>] (check_preemption_disabled+0x100/0x11c)
|[<c045427c>] (check_preemption_disabled) from [<c01164e4>] (__do_user_fault.constprop.2+0x78/0xa4)
|[<c01164e4>] (__do_user_fault.constprop.2) from [<c01168fc>] (do_page_fault+0x378/0x72c)
|[<c01168fc>] (do_page_fault) from [<c0116e24>] (do_DataAbort+0x3c/0xa8)
|[<c0116e24>] (do_DataAbort) from [<c0101d9c>] (__dabt_usr+0x3c/0x40)
|Exception stack(0xec899fb0 to 0xec899ff8)
|9fa0:                                     00000000 00000000 00000001 12345678
|9fc0: 00000000 004f7000 bffffff0 bffffff0 bedc9df4 bedc9c7c 004f7000 00000000
|9fe0: 00000000 bedc9c78 004e6559 004e6562 60010030 ffffffff
|Segmentation fault

So should harden_branch_predictor() be invoked before interrupts are enabled?

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
