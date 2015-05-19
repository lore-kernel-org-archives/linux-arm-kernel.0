From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 May 2015 10:34:26 +0100
Subject: [PATCH v2 08/11] mfd: mediatek: Add GPIO sub module support into
 mfd.
In-Reply-To: <1432015882-8646-9-git-send-email-hongzhou.yang@mediatek.com>
References: <1432015882-8646-1-git-send-email-hongzhou.yang@mediatek.com>
 <1432015882-8646-9-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <20150519093426.GS22418@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 May 2015, Hongzhou Yang wrote:

> Register pinctrl subnode into 6397 mfd cell.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c |    3 +++
>  1 file changed, 3 insertions(+)
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

I think the "mediatek-" part should be removed, no?

> +		.of_compatible = "mediatek,mt6397-pinctrl",
>  	},
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
