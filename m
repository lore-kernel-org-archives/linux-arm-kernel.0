From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 07:30:45 +0000
Subject: [PATCH v2 1/3] mfd: provide RTC resource in MT6397 MFD
In-Reply-To: <1426657537-41414-2-git-send-email-eddie.huang@mediatek.com>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150318073045.GE3318@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Mar 2015, Eddie Huang wrote:

> Provide MT6397 RTC interrupt, base address, and register in
> MT6397 MFD.
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index b61c4eb..ef431d8 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -21,9 +21,24 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  
> +static const struct resource mt6397_rtc_resources[] = {
> +	{
> +		.start = 0xe000,
> +		.end   = 0xe03e,

I'd like to see these defined please.

> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MT6397_IRQ_RTC,
> +		.end   = MT6397_IRQ_RTC,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
>  static const struct mfd_cell mt6397_devs[] = {
>  	{
>  		.name = "mt6397-rtc",
> +		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
> +		.resources = mt6397_rtc_resources,
>  		.of_compatible = "mediatek,mt6397-rtc",
>  	}, {
>  		.name = "mt6397-regulator",

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
