From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 04 Jul 2014 10:19:17 +0200
Subject: [PATCH RFC] imx-drm: convert imx-drm to use the generic DRM OF
 helper
In-Reply-To: <E1X2kFl-0000us-GN@rmk-PC.arm.linux.org.uk>
References: <E1X2kFl-0000us-GN@rmk-PC.arm.linux.org.uk>
Message-ID: <1404461957.2833.3.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Donnerstag, den 03.07.2014, 17:52 +0100 schrieb Russell King:
> Use the generic DRM OF helper to locate the possible CRTCs for the
> encoder, thereby shrinking the imx-drm driver some more.

Great, I especially like that now we don't go -EPROBE_DEFER anymore as
soon as a single crtc_mask doesn't check out so we can also start adding
output endpoints to encoders.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This patch builds upon "drm: add of_graph endpoint helper to find
> possible CRTCs", converting imx-drm to use this new helper.

There's a reference counting issue in the patch mentioned above,
but I'd like to fix this in of_graph_get_next_endpoint instead.
For both patches,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
