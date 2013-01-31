From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Jan 2013 22:26:03 +0800
Subject: [REGRESSION+BISECT] imx6: 3.8+: sata failure with 24d340ac "ARM
 i.MX6: Fix ethernet PLL clocks"
In-Reply-To: <20130131135351.GB5452@luxor.wired.org>
References: <20130131113627.GA5452@luxor.wired.org>
 <20130131133054.GD2735@S2101-09.ap.freescale.net>
 <20130131135351.GB5452@luxor.wired.org>
Message-ID: <20130131142602.GF2735@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 02:53:51PM +0100, Paolo Pisati wrote:
> On Thu, Jan 31, 2013 at 09:30:56PM +0800, Shawn Guo wrote:
> > 
> > Can you please try to see if the following change bring that SATA back
> > to work?
> > 
> > Shawn
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index c0c4e72..8f756af 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -436,6 +436,9 @@ int __init mx6q_clocks_init(void)
> >         for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
> >                 clk_prepare_enable(clk[clks_init_on[i]]);
> > 
> > +       if (IS_ENABLED(CONFIG_SATA_AHCI_PLATFORM))
> > +               clk_prepare_enable(clk[sata_ref_100m]);
> > +
> >         /* Set initial power mode */
> >         imx6q_set_lpm(WAIT_CLOCKED);
> 
> yes, it fixes SATA.
> 
> Tested-by: <p.pisati@gmail.com>

Just to be clear, I'm not sending this change to mainline, as I expect
someone who cares about SATA function adds this code when he submits
imx6q SATA support (that out of tree patch).

Shawn
