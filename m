From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 Mar 2017 14:42:37 +0000
Subject: [PATCH v5 4/4] mfd: mt6397: Add MT6323 LED support into MT6397
 driver
In-Reply-To: <1488549385-19899-5-git-send-email-sean.wang@mediatek.com>
References: <1488549385-19899-1-git-send-email-sean.wang@mediatek.com>
 <1488549385-19899-5-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170314144237.5b3kxhri4frmhboy@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 Mar 2017, sean.wang at mediatek.com wrote:

> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add compatible string as "mt6323-led" that will make
> the OF core spawn child devices for the LED subnode
> of that MT6323 MFD device.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 4 ++++
>  1 file changed, 4 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index e14d8b0..8e601c8 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -48,6 +48,10 @@
>  		.name = "mt6323-regulator",
>  		.of_compatible = "mediatek,mt6323-regulator"
>  	},
> +	{

Put this on the line above.

> +		.name = "mt6323-led",
> +		.of_compatible = "mediatek,mt6323-led"
> +	},
>  };
>  
>  static const struct mfd_cell mt6397_devs[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
