From: yong.shen@linaro.org (Yong Shen)
Date: Mon, 18 Oct 2010 17:08:14 +0800
Subject: [PATCHv2] cpufreq for freescale mx51
In-Reply-To: <20101018083106.GK28242@pengutronix.de>
References: <1286525307-1934-1-git-send-email-yong.shen@linaro.org>
	<1286525307-1934-2-git-send-email-yong.shen@linaro.org>
	<20101013175424.GU28242@pengutronix.de>
	<AANLkTimprV8=cAD-CfiAgLTCFyj=wc7qMj0sPDCUpWDC@mail.gmail.com>
	<20101018083106.GK28242@pengutronix.de>
Message-ID: <AANLkTimEdhXiLoxyqi0cSpWZDzDX7dwqchg8MEErEzQ2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,


On Mon, Oct 18, 2010 at 4:31 PM, Sascha Hauer <s.hauer@pengutronix.de>wrote:

> Hi Yong,
>
> On Mon, Oct 18, 2010 at 01:43:43PM +0800, Yong Shen wrote:
> > Hi Sascha,
> >
> > Thanks for your thorough review. I have two feedbacks to your commends.
> > Sorry for delayed response, cause I had a hard time due to my computer
> crash
> > and data loss.
> >
> > > diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> > > > index 2d37785..83add9c 100644
> > > > --- a/arch/arm/mach-mx5/cpu.c
> > > > +++ b/arch/arm/mach-mx5/cpu.c
> > > > @@ -22,6 +22,8 @@ static int cpu_silicon_rev = -1;
> > > >
> > > >  #define SI_REV 0x48
> > > >
> > > > +struct cpu_wp *(*get_cpu_wp)(int *wp);
> > > > +
> > >
> > > This is not needed.
> > >
> > This is needed, otherwise it does not pass compile.
>
> This hunk is the only change to arch/arm/mach-mx5/cpu.c and get_cpu_wp
> is introduced with this patch, so how can this break compilation?
> Also, you should move this to a header file. Otherwise you risk of
> having multiple (and possibly different) declarations of the same
> function which can lead to hard to find bugs.
>
IMHO,  get_cpu_wp is definition rather than a declaration and without it
there will be errors in link phase. its declaration is in
arch/arm/plat-mxc/include/mach/mxc.h.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101018/d4c26487/attachment-0001.html>
