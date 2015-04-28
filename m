From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Apr 2015 11:07:19 +0100
Subject: [PATCH v3 1/3] mfd: provide RTC resource in MT6397 MFD
In-Reply-To: <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150428100719.GN11956@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Apr 2015, Eddie Huang wrote:

> Provide MT6397 RTC interrupt, base address, and register in
> MT6397 MFD.
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

*after* Uwe's concerns have been attended to, you may add my:

Acked-by: Lee Jones <lee.jones@linaro.org>

FWIW, I quite like straight lines. :)

> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc780..08cfbd1 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -21,9 +21,27 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  
> +#define MT6397_RTC_BASE		0xe000
> +#define MT6397_RTC_SIZE		0x3e
> +
> +static const struct resource mt6397_rtc_resources[] = {
> +	{
> +		.start = MT6397_RTC_BASE,
> +		.end   = MT6397_RTC_BASE + MT6397_RTC_SIZE,
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
