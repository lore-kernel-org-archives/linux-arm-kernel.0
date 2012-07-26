From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:45:55 +0100
Subject: [PATCH 19/21] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <1343298534-13611-20-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-20-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726114554.GC3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:52AM +0100, Lee Jones wrote:

>  arch/arm/mach-ux500/board-mop500-msp.c |   14 --------------
>  arch/arm/mach-ux500/board-mop500.c     |    2 --
>  arch/arm/mach-ux500/board-mop500.h     |    2 --
>  sound/soc/ux500/ux500_msp_dai.c        |    6 ++++++
>  sound/soc/ux500/ux500_msp_i2s.c        |   33 +++++++++++++++++++++++++++++---

Always provide documentation for DT bindings.

> +void ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
> +			struct ux500_msp *msp,
> +			struct device_node *np)
> +{
> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
> +		msp->use_pinctrl = true;
> +	else
> +		msp->use_pinctrl = false;
> +}
> +

This doesn't seem particularly sane...  why is this conditional?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/5235da47/attachment.sig>
