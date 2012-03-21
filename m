From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Mar 2012 10:16:25 +0100
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <alpine.DEB.2.00.1203201740470.22974@utopia.booyaka.com>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
 <20120320141811.GF32469@S2101-09.ap.freescale.net>
 <20120320181050.GN3852@pengutronix.de>
 <alpine.DEB.2.00.1203201740470.22974@utopia.booyaka.com>
Message-ID: <20120321091625.GR3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 05:47:42PM -0600, Paul Walmsley wrote:
> Hello Sascha
> 
> On Tue, 20 Mar 2012, Sascha Hauer wrote:
> 
> > [ C99 structure initializer elided ]
> > 
> > This will make a 4000 line file out of a 500 line file. Now when for
> > some reason struct clk_divider changes we end with big patches. If the
> > clk core gets a new fancy CLK_ flag which we want to have then again
> > we end up with big patches. Then there's also the possibility that
> > someone finds out that .lock and .hw.flags are common to all dividers
> > and comes up with a #define DEFINE_CLK_DIVIDER again to share common
> > fields.
> 
> At least we can understand easily what is being changed.  Readability, 
> particularly by others not familiar with the clock data, is more important 
> to me.
> 
> So like Saravana, I too prefer C99 structure initializers.  At least there 
> should be a choice.
> 
> Quick quiz: in this line below:
> 
> imx_clk_divider("foo_clk", "bar_clk", CCM_BASE + 0x20, 0x5, 0x3);
> 
> which field is the bitfield shift and which is the bitfield width? :-)

I can't even remember the argument order in memset, but I never voted
for a struct memset_init ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
