From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 14:16:06 +0200
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionally
In-Reply-To: <20130501225748.GD6517@verge.net.au>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <CAL_JsqJWJvxezXy0RGFutxzvBhca-8=uRH2GxdJgzbEGw+OL0A@mail.gmail.com>
 <20130501225748.GD6517@verge.net.au>
Message-ID: <201305081416.06611.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Simon Horman wrote:
> > > diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
> > > index 8871f77..5dc57f1 100644
> > > --- a/arch/arm/mach-shmobile/intc-r8a7740.c
> > > +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
> > > @@ -53,14 +53,23 @@ static void __init r8a7740_init_irq_common(void)
> > >
> > >  void __init r8a7740_init_irq_of(void)
> > >  {
> > > +       if (!IS_ENABLED(CONFIG_OF))
> > > +               return;
> > > +
> > >         irqchip_init();
> > 
> > Why not have an empty irqchip_init? I'd guess we'll need this on other
> > platforms and your default mach.
> 
> Thanks, I think that could work.
> 
> I will see about making it so.

Ping

Linux-next is still broken for me. There is also anothe shmobile build bug,
I'll send a separate patch for that, which also needs to go into your tree.

	Arnd
