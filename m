Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48738C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:59:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124F12087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O9q7lH8h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OknqYSSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124F12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vUIJ1hGn8JTIYQlP1sQK8lGGwPkahB1E9Y+wOw23WO0=; b=O9q7lH8hzYL0uq
	oCzTLeTgUsYFmjT8PZMj4s3c1bXsAB1NfOWNBytR5V1thL0RstOaRsK/VUrxqb23XSzl4h4eV5Qm4
	jFYVR0sDg8Qu1mjEGJYV9WyyGDu7cd2ecCydrH+nutUPWk66rzKni3naxqPhCGaRiCbxe5eM6FvWs
	5Pa2mWkPqKxb7QxsnONhvU1bq5YLux7FyD18OvJOdLzXak6AT6k1QynoBn+bmt7lMJpHjqRT5ISB9
	pZTaTJgt2lvlrxDM0KiJ8Kx/4yROvvM15J0lZSc+maSK/j4G96tJUHL0z77M9vCavbazXvFmnwngh
	3EL3l60V0uS97B+tLJ/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpLIP-00061Q-OD; Thu, 31 Jan 2019 22:58:57 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpLIL-00060u-K6
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 22:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rIUvuQHRmHmh8KeNmIfw9LrJvwLfvfACuqc0WprBHmo=; b=OknqYSSCIkURIYlg+17XUEFt4
 9fVNL5sdxNQJAkybSyTj/jamwj/7618myr8WjUMN6ItU6/8Lsu92XIj3M12tD76nwjPuXottkCHQS
 AyVnCLdgG4bER80Q6MA31uNqLX7GqOIQPwsRfHg3FdtnnhDpYJOgAv31BkmP38i2XV1ZQ=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58272)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gpLID-0001w9-82; Thu, 31 Jan 2019 22:58:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gpLI4-0001Fn-SC; Thu, 31 Jan 2019 22:58:36 +0000
Date: Thu, 31 Jan 2019 22:58:36 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <20190131225836.tjnv2b5xjwjo3pu5@e5254000004ec.dyn.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
 <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
 <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
 <20190131135805.GD21965@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131135805.GD21965@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_145854_087951_7FC5DB1C 
X-CRM114-Status: GOOD (  34.77  )
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 01:58:05PM +0000, Will Deacon wrote:
> Hi Russell, Paul,
> 
> On Sun, Jan 27, 2019 at 03:28:50PM +0000, Russell King - ARM Linux admin wrote:
> > On Sun, Jan 27, 2019 at 01:15:31AM +0000, Paul Walmsley wrote:
> > > On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:
> > > > On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > > > > There was some concern in the past that WFE, like WFI, might cause the 
> > > > > core to assert an external signal that might cause the SoC integration to 
> > > > > place the core into a low-power mode from which it might not be able to 
> > > > > wake up.  This could happen on OMAP, for example, with WFI.
> > > > > 
> > > > > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > > > > reached?
> > > > 
> > > > First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> > > > low power state that it may not be able to wake up from, all our
> > > > spinlocks would be unsafe.
> > > 
> > > Good point.  WFE must not assert the external signal that indicates 
> > > that the core is inactive.
> > > 
> > > > Next, in all of the situations in this patch, we're executing an
> > > > infinite loop.  If it were to cause the core to go into a low power
> > > > mode, surely that's a good thing, rather than the core endlessly
> > > > executing NOPs?  The only way out of that is for the core to receive
> > > > a reset _anyway_.
> > > 
> > > Makes sense.  
> > > 
> > > Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?
> > 
> > I think there may be an erratum for this which specifies 10 NOPs as
> > its workaround, but I don't have its number.
> 
> The erratum hits because cpu_relax() is a DMB instruction due to erratum
> 754327. That then triggers erratum 794072 because a tight loop of DMB
> instructions can cause a denial of service. One of the conditions for that
> to occur is:
> 
>   | * No more than 10 instructions other than the DMB are executed between
>   |   each DMB
> 
> Digging up the workaround:
> 
>   |  This erratum can be worked round by setting bit[4] of the undocumented
>   |  Diagnostic Control Register to 1. This register is encoded as
>   |  CP15 c15 0 c0 1. This bit can be written in Secure state only, with the
>   |  following Read/Modify/Write code sequence:
>   |
>   |	MRC p15,0,rt,c15,c0,1
>   |	ORR rt,rt,#0x10
>   |	MCR p15,0,rt,c15,c0,1
>   |
>   |  When it is set, this bit causes the DMB instruction to be decoded and
>   |  executed like a DSB. Using this software workaround is not expected to
>   |  have any impact on the overall performance of the processor on a typical
>   |  code base.
>   |
>   |  Other workarounds are also available for this erratum, to either prevent
>   |  or interrupt the continuous stream of DMB instructions that causes the
>   |  deadlock.
>   |
>   |  For example:
>   |	* Inserting a non-conditional Load or Store instruction in the loop
>   |	  between each DMB
>   |	* Inserting additional instructions in the loop, such as NOPs, to
>   |       avoid the processor seeing back to back DMB instructions.
>   |	* Making the processor executing the short loop take regular
>   |	  interrupts.
> 
> So the reason I prefer the NOPs is because that's guaranteed by the h/w folks
> to do the trick, whereas they say nothing about WFE. It should be dead easy to
> use NOPs instead, so I'm not sure why we're not just following the workaround
> here. We could even use NOPs + WFE if you like!

Okay, let's start off at the beginning:

machine_crash_nonpanic_core() does this:

	while (1)
		cpu_relax();

because the kernel has crashed, and we have no known safe way to deal
with the CPU.  So, we place the CPU into an infinite loop which we
expect it to _never_ exit - at least not until the system as a whole is
reset by some method.

In the absence of 754327, this code assembles to:

	b	.

In other words, an infinite loop.  When 754327 is enabled, this
becomes:

1:	dmb
	b	1b

Now, it's been so long ago (the commit says April 2018), that I don't
remember _which_ of these triggered the problem in OMAP4 where, if a
crash is triggered, the system tries to kexec into the panic kernel,
but fails after taking the secondary CPU down - placing it into one
of these loops.

The test as working solution I came up with was to add wfe() to
these infinite loops thusly:

	while (1) {
		cpu_relax();
		wfe();
	}

which, without 754327 builds to:

1:	wfe
	b	1b

or with 754327 is enabled:

1:	dmb
	wfe
	b	1b

Adding "wfe" does two things - where we're running on bare metal, and
the processor implements "wfe", it stops us spinning endlessly in a
loop where we're never going to do any useful work.

If we hit one of these loops in a VM, it allows the CPU to be given
back to the hypervisor and rescheduled for other purposes (maybe a
different VM) rather than wasting CPU cycles inside a crashed VM.

However, in light of 794072, you decided you wanted to see 10 nops
as well - which is reasonable to cover the case where we have 754327
enabled _and_ we have a processor that doesn't implement the wfe
hint.

So, we now end up with:

1:	wfe
	b	1b

when 754327 is disabled, or:

1:	dmb
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	wfe
	b	1b

when 754327 is enabled.  We also get the dmb + 10 nop sequence
elsewhere in the kernel, in terminating loops.

IMHO, this is reasonable - it means we get the workaround for 794072
when 754327 is enabled, but still relinquish the dead processor -
either by placing it in a lower power mode when wfe is implemented as
such or by returning it to the hypervisior, or in the case where wfe
is a no-op, we use the workaround specified in 794072 to avoid the
problem.

I personally see these as two entirely orthogonal problems - the 10
nops addresses 794072, and the wfe is an optimisation that makes the
system more efficient when crashed either in terms of power consumption
or by allowing the host/other VMs to make use of the CPU.

I don't see any reason not to use kexec() inside a VM - it has the
potential to provide automated recovery from a failure of the VMs
kernel with the opportunity for saving a crashdump of the failure.
A panic() with a reboot timeout won't do that, and reading the
libvirt documentation, setting on_reboot to "preserve" won't either
(the documentation states "The preserve action for an on_reboot event
is treated as a destroy".)  Surely it has to be a good thing to
avoiding having CPUs spinning inside a VM that is doing no useful
work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
