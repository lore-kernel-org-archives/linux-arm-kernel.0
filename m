From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 24 Apr 2012 17:51:17 +0800
Subject: [PATCH v2 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <1334933916-12971-3-git-send-email-b29396@freescale.com>
References: <1334933916-12971-1-git-send-email-b29396@freescale.com>
 <1334933916-12971-3-git-send-email-b29396@freescale.com>
Message-ID: <20120424095116.GA28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <mach/esdhc.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -68,6 +69,7 @@ struct pltfm_imx_data {
>  	int flags;
>  	u32 scratchpad;
>  	enum imx_esdhc_type devtype;
> +	struct pinctrl *p;
>  	struct esdhc_platform_data boarddata;
>  };
>  
> @@ -467,6 +469,12 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	clk_prepare_enable(clk);
>  	pltfm_host->clk = clk;
>  
> +	imx_data->p = pinctrl_get_select_default(&pdev->dev);
devm_xxx version?

Thanks
Richard 
