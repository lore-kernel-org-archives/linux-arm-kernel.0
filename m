From: david@lechnology.com (David Lechner)
Date: Thu, 26 Apr 2018 20:58:01 -0500
Subject: [PATCH 4/4] ARM: davinci: board-omapl138-hawk: fix GPIO numbers
 for MMC/SD lookup
In-Reply-To: <20180424143506.25793-5-nsekhar@ti.com>
References: <20180424143506.25793-1-nsekhar@ti.com>
 <20180424143506.25793-5-nsekhar@ti.com>
Message-ID: <2b4b0262-0383-7512-4db1-d4f69170c429@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2018 09:35 AM, Sekhar Nori wrote:
> commit c4dc56be7e26 ("ARM: davinci: fix the GPIO lookup for omapl138-hawk")
> fixed the GPIO chip name for look-up of MMC/SD CD and WP pins, but forgot
> to change the GPIO numbers passed.
> 
> The GPIO numbers are not offsets from within a 32 GPIO bank. Fix the
> GPIO numbers as well as remove the misleading comment.
> 
> Fixes: c4dc56be7e26 ("ARM: davinci: fix the GPIO lookup for omapl138-hawk")
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm/mach-davinci/board-omapl138-hawk.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index 0d32042b728f..be8b892a6ea7 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -123,12 +123,16 @@ static const short hawk_mmcsd0_pins[] = {
>   	-1
>   };
>   
> +#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
> +#define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
> +
>   static struct gpiod_lookup_table mmc_gpios_table = {
>   	.dev_id = "da830-mmc.0",
>   	.table = {
> -		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
> -		GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
> -		GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_CD_PIN, "cd",
> +			    GPIO_ACTIVE_LOW),
> +		GPIO_LOOKUP("davinci_gpio.0", DA850_HAWK_MMCSD_WP_PIN, "wp",
> +			    GPIO_ACTIVE_LOW),
>   	},
>   };
>   
> 

Reviewed-by: David Lechner <david@lechnology.com>
