From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 14 Mar 2018 10:37:18 +0100
Subject: [PATCH v2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
In-Reply-To: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180314093717.glamqbj2curklztd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 06:54:37PM +0100, Giulio Benetti wrote:
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
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180314/762a6eea/attachment.sig>
