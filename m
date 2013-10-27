From: marex@denx.de (Marek Vasut)
Date: Sun, 27 Oct 2013 17:25:36 +0100
Subject: [PATCH v3 3/5] usb: chipidea: imx: set CI_HDRC_IMX28_WRITE_FIX
 for imx28
In-Reply-To: <1382680943-9258-3-git-send-email-peter.chen@freescale.com>
References: <1382680943-9258-1-git-send-email-peter.chen@freescale.com>
 <1382680943-9258-3-git-send-email-peter.chen@freescale.com>
Message-ID: <201310271725.37175.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> Due to imx28 needs ARM swp instruction for writing, we set
> CI_HDRC_IMX28_WRITE_FIX for imx28.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c |   32 ++++++++++++++++++++++++++------
>  1 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c
> b/drivers/usb/chipidea/ci_hdrc_imx.c index 023d3cb..68f7f5e 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -23,6 +23,26 @@
>  #include "ci.h"
>  #include "ci_hdrc_imx.h"
> 
> +#define CI_HDRC_IMX_IMX28_WRITE_FIX BIT(0)
> +
> +struct ci_hdrc_imx_platform_flag {
> +	unsigned int flags;
> +};
> +
> +static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
> +};
> +
> +static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
> +	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX,
> +};
> +
> +static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
> +	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
> +	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},

Just a nit-pick, but the order here is wrong ;-)
[...]
Best regards,
Marek Vasut
