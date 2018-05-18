From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 18 May 2018 17:26:51 +0200
Subject: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY
 clock parents
In-Reply-To: <4909574.Q3IFWM0xt6@jernej-laptop>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-13-jagan@amarulasolutions.com>
 <20180518100116.4bf2qcffg7ekxa7u@flea>
 <4909574.Q3IFWM0xt6@jernej-laptop>
Message-ID: <20180518152651.lfymc3kj7npj5tww@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 04:46:41PM +0200, Jernej ?krabec wrote:
> > And this is a bit sloppy, since if phy_clk_num == 3, you won't try to
> > lookup pll-2 either.
> 
> It is highly unlikely this will be higher than 2, at least for this HDMI PHY, 
> since it has only 1 bit reserved for parent selection. But since I have to fix 
> it, I'll add ">= 2"

If we're only going to have two parents at most, ever, why don't we
had just a single other boolean. This would be less intrusive, and we
wouldn't have to check for those corner cases.

> BTW, I'll resend fixed version of this patch for my R40 HDMI series, since 
> there is nothing to hold it back, unlike for this.

Awesome, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/0f026579/attachment.sig>
