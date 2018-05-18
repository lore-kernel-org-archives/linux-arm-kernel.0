From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 18 May 2018 17:34:48 +0200
Subject: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY
 clock parents
In-Reply-To: <20180518152651.lfymc3kj7npj5tww@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <4909574.Q3IFWM0xt6@jernej-laptop> <20180518152651.lfymc3kj7npj5tww@flea>
Message-ID: <3855913.NIurOIk8c1@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne petek, 18. maj 2018 ob 17:26:51 CEST je Maxime Ripard napisal(a):
> On Fri, May 18, 2018 at 04:46:41PM +0200, Jernej ?krabec wrote:
> > > And this is a bit sloppy, since if phy_clk_num == 3, you won't try to
> > > lookup pll-2 either.
> > 
> > It is highly unlikely this will be higher than 2, at least for this HDMI
> > PHY, since it has only 1 bit reserved for parent selection. But since I
> > have to fix it, I'll add ">= 2"
> 
> If we're only going to have two parents at most, ever, why don't we
> had just a single other boolean. This would be less intrusive, and we
> wouldn't have to check for those corner cases.

That works for me too. And since it's only the code, it can always be reworked 
if there is the need.

Best regards,
Jernej

> 
> > BTW, I'll resend fixed version of this patch for my R40 HDMI series, since
> > there is nothing to hold it back, unlike for this.
> 
> Awesome, thanks!
> Maxime
> 
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
