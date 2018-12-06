Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED45A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MTCitV0h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyiv/kYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED45A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LvquDOZcVKHPttJmuAcevmodMCr9kcNIl5UcVFwOWi0=; b=MTCitV0h7zEhG6
	ZchOqnr9OGDoQklL3OBGAtIhuPXKANjfPzUQHA2EIZGXz01qjYe01SiojaRPN8r5hGBwynYjUSM0H
	4pCzOcBbj25fxPBeJTORLooq9Cx3pe+oL3wIBfs4mGTjQ+AMc5wqwrDIOix+CpXEmh66FeAxPbPmH
	ewcia1sU69gcIbJIJjiknBizrDFkfeQfp2Z1HiVJgmdJF3+vsh1gU5z3gPhB2WYylul8RV258A/lg
	eo3F3hoT5oDJ2X9tdXb2lQSIAjusHEso6zml8wULHZ/i7IN5O0TkClAmhw5iibij8BDDRbAMk+EG3
	nXnvZbL/3X6UFCcFtIbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUu6z-0000yw-Cw; Thu, 06 Dec 2018 13:54:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUu6t-0000y4-OI
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:54:39 +0000
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47D4F20892
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544104464;
 bh=tUFkMIVgc/NgCC/y5N4JEGOfpv+o9ksK55ni/X4KQ2w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Yyiv/kYuOswLV2Qo/+bRDJzJtTsxd8mykcH4ch0RyceRJQaUu6tbhXzxx3Ke8OZ4o
 /wIz/+7/ibpr5Tl2v5/gcixnu18R6sgf+NSYcrELOXMHBrNkJmgSHkUzFbmsv6JpzC
 foWNXYz7LMJn7sMgll/kAVGedQhImiihzr2MgqCs=
Received: by mail-lj1-f179.google.com with SMTP id c19-v6so486170lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:54:24 -0800 (PST)
X-Gm-Message-State: AA+aEWb4HJIk3HLnOObW1hUeyIzHkU5DGNXWBLnUedJK/xoTCtoc199N
 QHtmcP0smUsl1B7cZtAmKwKqxSxHdx/EE/U7fNs=
X-Google-Smtp-Source: AFSGD/VA11NYYxBV2gwIMR1of8nYg72kJXO9Q7ubYTaXHMdfcRWk2M1x990+0YgtanfBq8vnN9LKbsazEd2pOFyTb80=
X-Received: by 2002:a2e:5d12:: with SMTP id
 r18-v6mr20269469ljb.89.1544104462334; 
 Thu, 06 Dec 2018 05:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
In-Reply-To: <20181206123956.GS30658@n2100.armlinux.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 6 Dec 2018 14:54:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
Message-ID: <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
To: linux@armlinux.org.uk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_055435_821490_93A8E279 
X-CRM114-Status: GOOD (  28.88  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, Qais.Yousef@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 13:40, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 06, 2018 at 11:24:27AM +0100, Krzysztof Kozlowski wrote:
> > On Thu, 6 Dec 2018 at 11:01, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > I've no idea based on what you've supplied given that the SoC
> > > maintainers are responsible for writing the code to deal with hotplug
> > > etc, and Exynos's code there is something of a maze.  It's not clear
> > > which bits are being used.  I think you at the very least need to debug
> > > to find out whether the problem is at CPU down or CPU up.
> > >
> > > From the ARM architecture point of view, for Cortex A9, all the
> > > processor function instances should be identical.  The only difference
> > > as a result of the patch is that we'll be calling smp_processor_id()
> > > early (which should be fine), and indirecting through the cpu_vtable[]
> > > array rather than merely dereferencing the processor struct.
> > >
> > > What about checking dmesg - messages from offline CPUs do not appear
> > > on the console(s) but are still logged in the kernel log.
> > >
> > > You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
> > > always access cpu_vtable[0]) to see whether it's the smp_processor_id()
> > > that's causing your problem or not.  If it is, then try and work out
> > > which of the processor functions is causing it by restoring
> > > PROC_VTABLE() and then switching each from PROC_VTABLE() to
> > > PROC_TABLE() until it does work.
> >
> > Thanks for hints!
>
> So I can plan, how long do you think it will take to get some results
> from my suggestions above?

For Suspend to RAM, on v4.20-rc3, this warning appears:
[   84.046722] WARNING: CPU: 1 PID: 0 at
../arch/arm/include/asm/proc-fns.h:124
secondary_start_kernel+0x214/0x26c
(difference between dcache_clean_area)
The secondary CPUs bringup fails with ETIMEDOUT.

Replacing all PROC_VTABLE -> PROC_TABLE improves a little bit - one
secondary CPU comes up, other timeout.
[   58.087004] Enabling non-boot CPUs ...
[   58.089116] ------------[ cut here ]------------
[   58.089138] WARNING: CPU: 1 PID: 0 at
../arch/arm/include/asm/proc-fns.h:124
secondary_start_kernel+0x208/0x264
[   58.089143] Modules linked in:
[   59.084017] CPU1: failed to boot: -110
[   59.085709] Error taking CPU1 up: -110
[   59.087667] ------------[ cut here ]------------
[   59.087683] WARNING: CPU: 2 PID: 0 at
../arch/arm/include/asm/proc-fns.h:126
secondary_start_kernel+0x240/0x264
[   59.087688] Modules linked in:
[   60.086049] CPU2: failed to boot: -110
[   60.086818] Error taking CPU2 up: -110
[   60.091198] CPU3 is up

For hotplug, making CPU online either fails with ETIMEDOUT or with segfault:
[   68.402951] WARNING: CPU: 1 PID: 0 at
../arch/arm/include/asm/proc-fns.h:126
secondary_start_kernel+0x24c/0x26c
[   68.402955] Modules linked in: s5p_cec
[   68.402966] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
  4.20.0-rc3 #149
[   68.402970] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   68.402981] [<c01122f8>] (unwind_backtrace) from [<c010e094>]
(show_stack+0x10/0x14)
[   68.402990] [<c010e094>] (show_stack) from [<c0a3987c>]
(dump_stack+0x98/0xc4)
[   68.402999] [<c0a3987c>] (dump_stack) from [<c0126ccc>] (__warn+0x10c/0x124)
[   68.403008] [<c0126ccc>] (__warn) from [<c0126dfc>]
(warn_slowpath_null+0x40/0x48)
[   68.403017] [<c0126dfc>] (warn_slowpath_null) from [<c0110c1c>]
(secondary_start_kernel+0x24c/0x26c)
[   68.403027] [<c0110c1c>] (secondary_start_kernel) from [<c01109a0>]
(arch_cpu_idle_dead+0x54/0x84)
[   68.403032] irq event stamp: 1028918
[   68.403039] hardirqs last  enabled at (1028917): [<c0a5b7cc>]
_raw_spin_unlock_irqrestore+0x6c/0x74
[   68.403047] hardirqs last disabled at (1028918): [<c0110964>]
arch_cpu_idle_dead+0x18/0x84
[   68.403054] softirqs last  enabled at (1028898): [<c012ecec>]
irq_enter+0x78/0x80
[   68.403061] softirqs last disabled at (1028897): [<c012ecd8>]
irq_enter+0x64/0x80
[   68.403065] ---[ end trace be591873dbd106ff ]---
[   68.403075] Unable to handle kernel paging request at virtual
address e7fddef0
[   68.403082] pgd = 06aec1fd
[   68.403086] [e7fddef0] *pgd=67e1141e(bad)
[   68.403097] Internal error: Oops: 8000000d [#1] PREEMPT SMP ARM
[   68.403103] Modules linked in: s5p_cec
[   68.403114] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
  4.20.0-rc3 #149
[   68.403118] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   68.403124] PC is at 0xe7fddef0
[   68.403131] LR is at secondary_start_kernel+0x98/0x26c
[   68.403137] pc : [<e7fddef0>]    lr : [<c0110a68>]    psr: 200f00d3
[   68.403142] sp : ee925fe8  ip : 00000000  fp : 00000000
[   68.403147] r10: c0d6a088  r9 : c0d6a088  r8 : 4000406a
[   68.403153] r7 : 00000002  r6 : 00000001  r5 : c100c67c  r4 : c1025ab0
[   68.403158] r3 : e7fddef0  r2 : ee8ab440  r1 : c1025ab0  r0 : 40004000
[   68.403165] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment none
[   68.403171] Control: 10c5387d  Table: 4000404a  DAC: 00000051
[   68.403177] Process swapper/1 (pid: 0, stack limit = 0xddfe9e0d)
[   68.403183] Stack: (0xee925fe8 to 0xee926000)
[   68.403192] 5fe0:                   00000001 c1007470 c10074b4
c01109a0 00000000 00000000
[   68.403203] [<c0110a68>] (secondary_start_kernel) from [<c01109a0>]
(arch_cpu_idle_dead+0x54/0x84)
[   68.403213] Code: 00004000 04000000 00000000 00000000 (00000001)
[   68.403221] ---[ end trace be591873dbd10700 ]---
[   68.403228] Kernel panic - not syncing: Attempted to kill the idle task!

The c0110a68 from secondary_start_kernel pointed to local_flush_bp_all
arch/arm/include/asm/tlbflush.h:550

I need definitely more time for narrowing this down. It might be that
some other changes are affecting this as well.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
