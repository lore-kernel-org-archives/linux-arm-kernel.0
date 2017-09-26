From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:58:38 +0200
Subject: [PATCH v2 06/13] drm/sun4i: hdmi: Allow using second PLL as TMDS
 clk parent
In-Reply-To: <20170926065919.24446-7-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-7-wens@csie.org>
Message-ID: <20170926095838.vvgdnm7bdodwtjzv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:12AM +0000, Chen-Yu Tsai wrote:
> Allwinner SoCs typically have two PLLs reserved for video related usage.
> At the moment we only support using the first one to feed the HDMI
> transmitter block's TMDS clock.
> 
> Let the HDMI encoder's TMDS clock go through all of its parents when
> calculating possible clock rates. This allows usage of the second video
> PLL as its parent.
> 
> Note that this does not handle conflicting pixel clocks. It is entirely
> possible to have an LCD panel use one pixel clock rate, only to be
> overridden by the HDMI transmitter's clock rate request when the second
> display pipeline is enabled.
> 
> This should be handled by having all the clock drivers honor clock rate
> ranges, and have the consumers use clk_set_rate_min/clk_set_rate_max.

That, or relying on clk_set_rate_protect

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/cdcc1c49/attachment-0001.sig>
