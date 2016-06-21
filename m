From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 10:40:18 +0800
Subject: [PATCH 1/2] ARM: imx6: disable deeper idle states when FEC is
 active w/o HW workaround
In-Reply-To: <4916175.LqH9s7UaP8@wuerfel>
References: <1464794983-31484-1-git-send-email-l.stach@pengutronix.de>
 <1464794983-31484-2-git-send-email-l.stach@pengutronix.de>
 <4916175.LqH9s7UaP8@wuerfel>
Message-ID: <20160621024018.GA21364@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 05:47:26PM +0200, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 5:29:42 PM CEST Lucas Stach wrote:
> > +/*
> > + * i.MX6 Q/DL has an erratum (ERR006687) that prevents the FEC from waking the
> > + * CPUs when they are in wait(unclocked) state. As the hardware workaround isn't
> > + * applicable to all boards, disable the deeper idle state when the workaround
> > + * isn't present and the FEC is in use.
> > + */
> > +void imx6q_cpuidle_fec_irqs_used(void)
> > +{
> > +       imx6q_cpuidle_driver.states[1].disabled = true;
> > +}
> > +
> > +void imx6q_cpuidle_fec_irqs_unused(void)
> > +{
> > +       imx6q_cpuidle_driver.states[1].disabled = false;
> > +}
> > +
> 
> These functions need to be exported, I just saw a build error in
> an allmodconfig test:
> 
> ERROR: "imx6q_cpuidle_fec_irqs_unused" [drivers/net/ethernet/freescale/fec.ko] undefined!
> ERROR: "imx6q_cpuidle_fec_irqs_used" [drivers/net/ethernet/freescale/fec.ko] undefined!

Thanks for the report, Arnd.  Just sent a fix for it.

Shawn
