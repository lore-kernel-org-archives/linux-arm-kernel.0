From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 May 2015 08:22:28 +0100
Subject: [PATCH 05/10] pinctrl: mediatek: Add Pinctrl/GPIO driver for
 mt6397.
In-Reply-To: <1431567346-33780-6-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-6-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <20150514072228.GB20358@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 May 2015, Hongzhou Yang wrote:

> Add mt6397 support using mediatek common pinctrl driver.
> 
> mt6397 is a PMIC, and pinctrl/GPIO is part of 6397 chip.
> Pinctrl/GPIO driver should obtain regmap from PMIC,
> so adding this support to common code.
> 
> Also, mt6397 is no need to support interrupt controller,
> so changing common code to skip it.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c                     |    3 +

Please break this out into a separate patch that I can take through my
tree.  There is no need for you to bind up changes in multiple
subsystems here.

>  drivers/pinctrl/mediatek/Kconfig              |    6 +
>  drivers/pinctrl/mediatek/Makefile             |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt6397.c     |   78 +++++
>  drivers/pinctrl/mediatek/pinctrl-mt8135.c     |    2 +-
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c     |    2 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   13 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    3 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h |  424 +++++++++++++++++++++++++
>  9 files changed, 527 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6397.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc780..012c620 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -34,6 +34,9 @@ static const struct mfd_cell mt6397_devs[] = {
>  	}, {
>  		.name = "mt6397-clk",
>  		.of_compatible = "mediatek,mt6397-clk",
> +	}, {
> +		.name = "mediatek-mt6397-pinctrl",
> +		.of_compatible = "mediatek,mt6397-pinctrl",
>  	},
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
