From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Apr 2012 10:33:35 +0200
Subject: [PATCH 1/2] ARM: fix builds due to missing <asm/system_misc.h>
 includes
In-Reply-To: <1333118281-25295-1-git-send-email-olof@lixom.net>
References: <1333118281-25295-1-git-send-email-olof@lixom.net>
Message-ID: <4F79645F.8050808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2012 04:38 PM, Olof Johansson :
> This does a sweeping change fixing up all the missing system_misc.h and
> system_info.h includes from the system.h split-up change. These were the
> ones I came across when building all defconfigs in arch/arm/configs, there
> might be more but they lack adequate build coverage to be easily caught.
> 
> I'm expecting to get a lot of these piecemeal by each maintainer, so we
> might just as well do one sweeping change to get them all at once.
> 
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Olof,

Even if it is a bit too late:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

It replaces the previously sent patch:
(ARM: at91: include newly created system_misc.h file).

Thanks a lot for taking care of this.

Cheers,


> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-at91/at91x40.c  |    1 +
>  arch/arm/mach-at91/setup.c    |    1 +
>  arch/arm/mach-h720x/common.c  |    1 +
>  arch/arm/mach-imx/mm-imx3.c   |    1 +
>  arch/arm/mach-imx/mm-imx5.c   |    1 +
>  arch/arm/mach-ixp23xx/core.c  |    1 +
>  arch/arm/mach-ixp4xx/common.c |    1 +
>  arch/arm/mach-pxa/raumfeld.c  |    2 ++
>  arch/arm/mach-shark/core.c    |    1 +
>  arch/arm/mach-w90x900/dev.c   |    1 +
>  arch/arm/plat-s3c24xx/cpu.c   |    1 +
>  11 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
> index 5400a1d..d62fe09 100644
> --- a/arch/arm/mach-at91/at91x40.c
> +++ b/arch/arm/mach-at91/at91x40.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <asm/proc-fns.h>
> +#include <asm/system_misc.h>
>  #include <asm/mach/arch.h>
>  #include <mach/at91x40.h>
>  #include <mach/at91_st.h>
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 1083739..97cc04d 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -11,6 +11,7 @@
>  #include <linux/pm.h>
>  #include <linux/of_address.h>
>  
> +#include <asm/system_misc.h>
>  #include <asm/mach/map.h>
>  
>  #include <mach/hardware.h>
> diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
> index e756d1a..aa1331e 100644
> --- a/arch/arm/mach-h720x/common.c
> +++ b/arch/arm/mach-h720x/common.c
> @@ -24,6 +24,7 @@
>  #include <asm/dma.h>
>  #include <mach/hardware.h>
>  #include <asm/irq.h>
> +#include <asm/system_misc.h>
>  #include <asm/mach/irq.h>
>  #include <asm/mach/map.h>
>  #include <mach/irqs.h>
> diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
> index d534d7f..7412738 100644
> --- a/arch/arm/mach-imx/mm-imx3.c
> +++ b/arch/arm/mach-imx/mm-imx3.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  
>  #include <asm/pgtable.h>
> +#include <asm/system_misc.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/map.h>
>  
> diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
> index 51af9fa..05250ae 100644
> --- a/arch/arm/mach-imx/mm-imx5.c
> +++ b/arch/arm/mach-imx/mm-imx5.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/clk.h>
>  
> +#include <asm/system_misc.h>
>  #include <asm/mach/map.h>
>  
>  #include <mach/hardware.h>
> diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
> index d2c2dc3..d345424 100644
> --- a/arch/arm/mach-ixp23xx/core.c
> +++ b/arch/arm/mach-ixp23xx/core.c
> @@ -36,6 +36,7 @@
>  #include <asm/irq.h>
>  #include <asm/tlbflush.h>
>  #include <asm/pgtable.h>
> +#include <asm/system_misc.h>
>  
>  #include <asm/mach/map.h>
>  #include <asm/mach/time.h>
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index c60e7b8..ebbd7fc 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -37,6 +37,7 @@
>  #include <asm/page.h>
>  #include <asm/irq.h>
>  #include <asm/sched_clock.h>
> +#include <asm/system_misc.h>
>  
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
> diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
> index 7d691e5..5905ed1 100644
> --- a/arch/arm/mach-pxa/raumfeld.c
> +++ b/arch/arm/mach-pxa/raumfeld.c
> @@ -43,6 +43,8 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/delay.h>
>  
> +#include <asm/system_info.h>
> +
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
> index 6a2a7f2..2704bcd 100644
> --- a/arch/arm/mach-shark/core.c
> +++ b/arch/arm/mach-shark/core.c
> @@ -15,6 +15,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/leds.h>
>  #include <asm/param.h>
> +#include <asm/system_misc.h>
>  
>  #include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
> index db82568..48f5b9f 100644
> --- a/arch/arm/mach-w90x900/dev.c
> +++ b/arch/arm/mach-w90x900/dev.c
> @@ -27,6 +27,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
>  
> +#include <asm/system_misc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
> diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
> index 0db73ae..290942d 100644
> --- a/arch/arm/plat-s3c24xx/cpu.c
> +++ b/arch/arm/plat-s3c24xx/cpu.c
> @@ -36,6 +36,7 @@
>  #include <asm/irq.h>
>  #include <asm/cacheflush.h>
>  #include <asm/system_info.h>
> +#include <asm/system_misc.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>


-- 
Nicolas Ferre
