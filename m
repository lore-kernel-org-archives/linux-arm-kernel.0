From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Jun 2012 11:31:35 +0200
Subject: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
In-Reply-To: <201206132110.31011.arnd@arndb.de>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
 <201206132110.31011.arnd@arndb.de>
Message-ID: <20120614093135.GE4799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 09:10:30PM +0000, Arnd Bergmann wrote:
> On Sunday 10 June 2012, Andrew Lunn wrote:
> > @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
> >         { }
> >  };
> >  
> > +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> > +       OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> > +       {},
> > +};
> > +
> >  static void __init kirkwood_dt_init(void)
> >  {
> 
> How about instead adding the clkdev for "f1010600.spi" so you don't need the auxdata?

We either have auxdata and clean clock code, or no auxdata and messy
clock code with lots of aliases.

The auxdata is also not limited to the name of the clocks. It allows
me to diff the kernel log for a DT boot and a none DT boot of the same
box and see they are identical. I've found a few typo's that way, and
not been hindered by noise of the devices changing name is useful.

Once we have the clock tree described in DT, then i think it makes
sense to remove these auxdata entries.

      Andrew
