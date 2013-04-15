From: zhangwm@marvell.com (Neil Zhang)
Date: Mon, 15 Apr 2013 04:09:21 -0700
Subject: [PATCH 2/4] ARM: mmp: move function declaration to head file
In-Reply-To: <CAN1soZyibQLOkeeZAi-8kWVJtgS9z9g0kyVSGunP-QO4dEkuzg@mail.gmail.com>
References: <1365651463-11502-1-git-send-email-zhangwm@marvell.com>
 <1365651463-11502-3-git-send-email-zhangwm@marvell.com>
 <CAN1soZyibQLOkeeZAi-8kWVJtgS9z9g0kyVSGunP-QO4dEkuzg@mail.gmail.com>
Message-ID: <175CCF5F49938B4D99B2E3EF7F558EBE2D0F68CFD7@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> -----Original Message-----
> From: Haojian Zhuang [mailto:haojian.zhuang at gmail.com]
> Sent: 2013?4?13? 20:59
> To: Neil Zhang
> Cc: Grant Likely; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; Chao Xie
> Subject: Re: [PATCH 2/4] ARM: mmp: move function declaration to head file
> 
> On Thu, Apr 11, 2013 at 11:37 AM, Neil Zhang <zhangwm@marvell.com>
> wrote:
> > Move some of the function declaration to head file.
> >
> > Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> > Signed-off-by: Chao Xie <chao.xie@marvell.com>
> > ---
> >  arch/arm/mach-mmp/common.h  |    3 +++
> >  arch/arm/mach-mmp/mmp-dt.c  |    3 ---
> >  arch/arm/mach-mmp/mmp2-dt.c |    3 ---
> >  3 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-mmp/common.h
> b/arch/arm/mach-mmp/common.h
> > index 0bdc50b..8c9b510 100644
> > --- a/arch/arm/mach-mmp/common.h
> > +++ b/arch/arm/mach-mmp/common.h
> > @@ -8,3 +8,6 @@ extern void mmp_restart(char, const char *);  extern
> > void __init pxa168_clk_init(void);  extern void __init
> > pxa910_clk_init(void);  extern void __init mmp2_clk_init(void);
> > +
> > +extern void __init mmp_dt_irq_init(void); extern void __init
> > +mmp_dt_init_timer(void);
> 
> It's better to make use of of_irq_init() & CLOCKSOURCE_OF_DECLARE() for
> timer. So I'll move mmp timer into clocksource & mmp irq into irqchip
> directory in the next week. You can rebase your code. Is it OK?
> 

Ok, I'll rebase after your update.


> > diff --git a/arch/arm/mach-mmp/mmp-dt.c
> b/arch/arm/mach-mmp/mmp-dt.c
> > index d063efa..af0bb5b 100644
> > --- a/arch/arm/mach-mmp/mmp-dt.c
> > +++ b/arch/arm/mach-mmp/mmp-dt.c
> > @@ -19,9 +19,6 @@
> >
> >  #include "common.h"
> >
> > -extern void __init mmp_dt_irq_init(void); -extern void __init
> > mmp_dt_init_timer(void);
> > -
> >  static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst
> = {
> >         OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000,
> "pxa2xx-uart.0", NULL),
> >         OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000,
> "pxa2xx-uart.1",
> > NULL), diff --git a/arch/arm/mach-mmp/mmp2-dt.c
> > b/arch/arm/mach-mmp/mmp2-dt.c index fad431a..4ba1fbe 100644
> > --- a/arch/arm/mach-mmp/mmp2-dt.c
> > +++ b/arch/arm/mach-mmp/mmp2-dt.c
> > @@ -21,9 +21,6 @@
> >
> >  #include "common.h"
> >
> > -extern void __init mmp_dt_irq_init(void); -extern void __init
> > mmp_dt_init_timer(void);
> > -
> >  static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst
> = {
> >         OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4030000,
> "pxa2xx-uart.0", NULL),
> >         OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000,
> "pxa2xx-uart.1",
> > NULL),
> > --
> > 1.7.4.1
> >

Best Regards,
Neil Zhang
