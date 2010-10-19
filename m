From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 19 Oct 2010 16:31:32 +0800
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <20101018093121.GM28242@pengutronix.de>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
	<20101013175424.GU28242@pengutronix.de>
	<AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
	<20101018083106.GK28242@pengutronix.de>
	<AANLkTimEdhXiLoxyqi0cSpWZDzDX7dwqchg8MEErEzQ2@mail.gmail.com>
	<20101018093121.GM28242@pengutronix.de>
Message-ID: <AANLkTik=gGF3A=hX8hURKpuEowBON3R=aAci6QjkZy2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>
> > > > > >
> > > > > > +struct cpu_wp *(*get_cpu_wp)(int *wp);
> > > > > > +
> > > > >
> > > > > This is not needed.
> > > > >
> > > > This is needed, otherwise it does not pass compile.
> > >
> > > This hunk is the only change to arch/arm/mach-mx5/cpu.c and get_cpu_wp
> > > is introduced with this patch, so how can this break compilation?
> > > Also, you should move this to a header file. Otherwise you risk of
> > > having multiple (and possibly different) declarations of the same
> > > function which can lead to hard to find bugs.
> > >
> > IMHO,  get_cpu_wp is definition rather than a declaration and without it
> > there will be errors in link phase. its declaration is in
> > arch/arm/plat-mxc/include/mach/mxc.h.
>
> Of course, you are right, my bad. Isn't this function common to al
> i.MXs? In this case it should be somewhere in plat-mxc.
> Anyway, it seems very odd to me to provide a global function pointer
> which gets overwritten by the boards. For me it is more logical to
> provide a mxc_register_workpoints() function along with a
> mxc_for_each_workpoint() iterator.
>
> About this, I am thinking move  the global function pointer to
plat-mxc/cpufreq.c and add protection before call the function pointer.
Anyway, it is just about provide cpu operating points to cpufreq driver,
right? Even, mxc_register_workpoints() has to go some where in cpufreq.c and
export a declaration in a head file, also it needs to be called before
cpufreq initialization. IMO, it's merely a preference of individuals. No
offence about that, correct me:)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/505075ec/attachment-0001.html>
