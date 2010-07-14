From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Jul 2010 14:06:49 +0900
Subject: [PATCH 3/3] arm: s5pv210: GONI: add support for MAX8998 PMIC
In-Reply-To: <1278321416-32524-4-git-send-email-m.szyprowski@samsung.com>
References: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
	<1278321416-32524-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <006201cb2312$646b05b0$2d411110$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> This patch adds required platform definitions for MAX8998 PMIC driver.
Power
> regulators for LDO and BUCK outputs has been defined as well as a simple
> gpio-keys button for power key (to enable wakeup functionality with
> external interrupt).

Almost same with previous patch...except ldo7_data, ldo17_data and
name...Hmm...
See the previous comments...

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/mach-goni.c |  323
> +++++++++++++++++++++++++++++++++++++
>  1 files changed, 323 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 05b4a1a..f0eaf86 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -13,8 +13,13 @@
>  #include <linux/init.h>
>  #include <linux/serial_core.h>
>  #include <linux/fb.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-gpio.h>
> +#include <linux/mfd/max8998.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> 
No need inclusion linux/gpio.h and plat/gpio-cfg.h?

>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -107,9 +112,323 @@ static struct s3c_fb_platdata goni_lcd_pdata
__initdata
> = {
>  	.setup_gpio		= s5pv210_fb_gpio_setup_24bpp,
>  };
> 

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
