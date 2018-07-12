From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 19:06:25 +0200
Subject: [PATCH v2] drm/sun4i: Implement zpos for DE2
In-Reply-To: <20180706164732.24166-1-jernej.skrabec@siol.net>
References: <20180706164732.24166-1-jernej.skrabec@siol.net>
Message-ID: <20180712170625.4w7zwmhkzbb4h5hc@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 06:47:32PM +0200, Jernej Skrabec wrote:
> Initial implementation of DE2 planes only supported fixed zpos.
> 
> Expand implementation with configurable zpos property.
> 
> Implementation background:
> Channel in DE2 driver represents one DRM plane, whereas pipe is just
> mapped channel to known Z position. Pipe 0 will always be at the bottom,
> pipe 1 just above pipe 0 and so on. If, for example, channel 1 is mapped
> at pipe 0 and channel 0 at pipe 1, whatever is on channel 0 will appear
> on top.
> 
> Before this commit, channel id was used for addressing channel related
> registers (prefixed with SUN8I_MIXER_CHAN_UI_ or SUN8I_MIXER_CHAN_VI_)
> and pipe registers (prefixed with SUN8I_MIXER_BLEND_). Additionally,
> register SUN8I_MIXER_BLEND_ROUTE, which takes care for mapping channels
> to pipes had fixed value. It mapped channel 0 to pipe 0, 1 to 1 and so
> on. Consequence of all that was fixed Z order of planes.
> 
> With this commit, pipe registers are using zpos property as index and
> channel related registers still use channel id as index. Pipe mapping
> register is now set dynamically too and pipe enable register is rebuild
> every time to make sure only active pipes are enabled.
> 
> Testing was done to confirm that there is no issues if bottom plane
> contains pixels with alpha value < 0xff and if it doesn't whole screen.
> 
> Tested-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180712/c3b4d348/attachment-0001.sig>
