From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Thu, 15 Jun 2017 08:58:10 +0000
Subject: [PATCH] staging: fsl-mc/dpio: Propagate error code
In-Reply-To: <20170615085506.31784-1-ruxandra.radulescu@nxp.com>
References: <20170615085506.31784-1-ruxandra.radulescu@nxp.com>
Message-ID: <DB5PR04MB12401B2E39BC94F7DAD4B49CEAC00@DB5PR04MB1240.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ioana Radulescu [mailto:ruxandra.radulescu at nxp.com]
> Sent: Thursday, June 15, 2017 11:55 AM
> To: gregkh at linuxfoundation.org
> Cc: devel at driverdev.osuosl.org; linux-kernel at vger.kernel.org;
> agraf at suse.de; arnd at arndb.de; linux-arm-kernel at lists.infradead.org; Bogdan
> Purcareata <bogdan.purcareata@nxp.com>; stuyoder at gmail.com; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; Ruxandra Ioana Radulescu
> <ruxandra.radulescu@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; Haiying Wang
> <haiying.wang@nxp.com>
> Subject: [PATCH] staging: fsl-mc/dpio: Propagate error code
> 
> dpaa2_io_service_register() returns zero even if
> qbman_swp_CDAN_set() encountered an error. Fix this
> by propagating the error code so the caller is informed
> data availability notifications are not properly set
> for a channel.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>

Acked-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>

> ---
>  drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
> b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
> index e5d66749614c..762f045f53f7 100644
> --- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
> +++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
> @@ -260,9 +260,9 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
> 
>  	/* Enable the generation of CDAN notifications */
>  	if (ctx->is_cdan)
> -		qbman_swp_CDAN_set_context_enable(d->swp,
> -						  (u16)ctx->id,
> -						  ctx->qman64);
> +		return qbman_swp_CDAN_set_context_enable(d->swp,
> +							 (u16)ctx->id,
> +							 ctx->qman64);
>  	return 0;
>  }
>  EXPORT_SYMBOL(dpaa2_io_service_register);
> --
> 2.11.0
