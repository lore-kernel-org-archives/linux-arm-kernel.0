From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 13 Jan 2015 13:08:12 +0200
Subject: [PATCH v7 1/3] of: Decrement refcount of previous endpoint in
 of_graph_get_next_endpoint
In-Reply-To: <1419340158-20567-2-git-send-email-p.zabel@pengutronix.de>
References: <1419340158-20567-1-git-send-email-p.zabel@pengutronix.de>
 <1419340158-20567-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <54B4FC9C.2050207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/12/14 15:09, Philipp Zabel wrote:
> Decrementing the reference count of the previous endpoint node allows to
> use the of_graph_get_next_endpoint function in a for_each_... style macro.
> All current users of this function that pass a non-NULL prev parameter
> (coresight, rcar-du, imx-drm, soc_camera, and omap2-dss) are changed to
> not decrement the passed prev argument's refcount themselves.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Changes since v6:
>  - Added omap2-dss.
>  - Added Mathieu's ack.
> ---
>  drivers/coresight/of_coresight.c                  | 13 ++-----------
>  drivers/gpu/drm/imx/imx-drm-core.c                | 13 ++-----------
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c             | 15 ++++-----------
>  drivers/media/platform/soc_camera/soc_camera.c    |  3 ++-
>  drivers/of/base.c                                 |  9 +--------
>  drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |  7 +------
>  6 files changed, 12 insertions(+), 48 deletions(-)
> 

For omapdss:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/d171a937/attachment.sig>
