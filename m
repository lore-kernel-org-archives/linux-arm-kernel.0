From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 16:55:59 +0100
Subject: [PATCH] drm/sun4i: init dclk_min_div & dclk_max_div inside
 encoder init functions
In-Reply-To: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519822318-3974-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <20180228155559.lqm22dzeiptrwyxe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 28, 2018 at 01:51:58PM +0100, Giulio Benetti wrote:
> sun4i_dclk_round_rate is called before sun4i_tcon_mode_set,
> so it finds dclk_min_div and dclk_max_div set to 0 and fails
> adding crtc.
> 
> Move dclk_min_div and dclk_max_div to encoders init functions.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

I sent a similar patch there:
https://lists.freedesktop.org/archives/dri-devel/2018-February/166666.html

I guess eventually, we'll want to remove the usage of the clock
framework entirely, but it's not really the scope of a fix.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/a9de232c/attachment.sig>
