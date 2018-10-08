From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 8 Oct 2018 11:21:11 +0200
Subject: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
In-Reply-To: <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
Message-ID: <20181008092111.qcufr4o7cy3nnj4b@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> If tcon->panel pointer is NULL, trying to dereference from it
> (i.e. tcon->panel->connector) will cause a null pointer dereference.
> 
> Add tcon->panel null pointer check before calling
> sun4i_tcon0_mode_set_dithering().
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
>                       RGB565/RGB666 LCD panels")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied both, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/46145777/attachment.sig>
