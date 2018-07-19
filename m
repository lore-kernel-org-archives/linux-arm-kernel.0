From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Jul 2018 17:37:06 +0200
Subject: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE checking if
 panel is used.
In-Reply-To: <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <20180718142357.120998-1-giulio.benetti@micronovasrl.com>
Message-ID: <20180719153706.j7rcqfu37e3ghtem@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 04:23:57PM +0200, Giulio Benetti wrote:
> Handle both positive and negative dclk polarity,
> according to bus_flags, taking care of this:
> 
> On A20 and similar SoCs, the only way to achieve Positive Edge
> (Rising Edge), is setting dclk clock phase to 2/3(240?).
> By default TCON works in Negative Edge(Falling Edge), this is why phase
> is set to 0 in that case.
> Unfortunately there's no way to logically invert dclk through IO_POL
> register.
> The only acceptable way to work, triple checked with scope,
> is using clock phase set to 0? for Negative Edge and set to 240? for
> Positive Edge.
> On A33 and similar SoCs there would be a 90? phase option, but it divides
> also dclk by 2.
> This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
> for using A33 90? phase divided by 2 and consequently increase code
> complexity.
> 
> Check if panel is used. TCON can also handle VGA DAC, then panel could
> be empty.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/1a52c4f9/attachment.sig>
