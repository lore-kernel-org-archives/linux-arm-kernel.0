From: horms@verge.net.au (Simon Horman)
Date: Thu, 9 May 2013 12:38:19 +0900
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionally
In-Reply-To: <CABYn4sxrcGmnTAJcQR23nMGy8JvqyDrgPOXF4yBFFU_4C8Pc_g@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <CAL_JsqJWJvxezXy0RGFutxzvBhca-8=uRH2GxdJgzbEGw+OL0A@mail.gmail.com>
 <20130501225748.GD6517@verge.net.au>
 <201305081416.06611.arnd@arndb.de>
 <CABYn4sxrcGmnTAJcQR23nMGy8JvqyDrgPOXF4yBFFU_4C8Pc_g@mail.gmail.com>
Message-ID: <20130509033819.GC13994@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 03:22:22PM +0200, Bastian Hecht wrote:
> Hi,
> 
> 2013/5/8 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 02 May 2013, Simon Horman wrote:
> >> > > diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
> >> > > index 8871f77..5dc57f1 100644
> >> > > --- a/arch/arm/mach-shmobile/intc-r8a7740.c
> >> > > +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
> >> > > @@ -53,14 +53,23 @@ static void __init r8a7740_init_irq_common(void)
> >> > >
> >> > >  void __init r8a7740_init_irq_of(void)
> >> > >  {
> >> > > +       if (!IS_ENABLED(CONFIG_OF))
> >> > > +               return;
> >> > > +
> >> > >         irqchip_init();
> >> >
> >> > Why not have an empty irqchip_init? I'd guess we'll need this on other
> >> > platforms and your default mach.
> >>
> >> Thanks, I think that could work.
> >>
> >> I will see about making it so.
> >
> > Ping
> 
> I have sent out a patch adding an empty irqchip_init() when
> CONFIG_IRQCHIP is not set with the subject
> [PATCH] irqchip: Add irqchip_init dummy function

Thanks.

> > Linux-next is still broken for me. There is also anothe shmobile build bug,
> > I'll send a separate patch for that, which also needs to go into your tree.

Sorry about that. I though I had pushed your fix (the first hunk of the
patch that started this thread), but it seems that I did not.

> Oh thanks Arnd for this fix!
> 
> Cheers,
> 
>  Bastian
