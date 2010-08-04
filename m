From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 5 Aug 2010 08:38:15 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix on inclusion mach/gpio.h for Samsung
	SoCs
In-Reply-To: <1280963229-3501-1-git-send-email-kgene.kim@samsung.com>
References: <1280963229-3501-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTi=tW4cFwLBDV9znHABqkOTKRJtjo+RC8bjKk_jG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Aug 5, 2010 at 8:07 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch fixes on inclusion <mach/gpio.h> to <linux/gpio.h>.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> ?arch/arm/mach-s3c64xx/dev-audio.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s3c64xx/dev-spi.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s3c64xx/gpiolib.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s3c64xx/setup-fb-24bpp.c ? | ? ?2 +-
> ?arch/arm/mach-s3c64xx/setup-i2c0.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-s3c64xx/setup-i2c1.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-s3c64xx/setup-sdhci-gpio.c | ? ?2 +-
> ?arch/arm/mach-s5p6440/dev-audio.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5p6440/dev-spi.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5p6440/gpio.c ? ? ? ? ? ? | ? ?4 +++-
> ?arch/arm/mach-s5p6442/dev-audio.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5p6442/dev-spi.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5pc100/dev-audio.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5pc100/dev-spi.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5pv210/dev-audio.c ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5pv210/dev-spi.c ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-s5pv210/setup-fb-24bpp.c ? | ? ?2 +-
> ?arch/arm/mach-s5pv210/setup-i2c0.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-s5pv210/setup-i2c1.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-s5pv210/setup-i2c2.c ? ? ? | ? ?2 +-
> ?arch/arm/mach-s5pv210/setup-sdhci-gpio.c | ? ?2 +-
> ?21 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
> index c3e9e73..9648fbc 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -12,11 +12,11 @@
> ?#include <linux/string.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/irqs.h>
> ?#include <mach/map.h>
> ?#include <mach/dma.h>
> -#include <mach/gpio.h>
>
> ?#include <plat/devs.h>
> ?#include <plat/audio.h>
> diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
> index 29c32d0..a492b98 100644
> --- a/arch/arm/mach-s3c64xx/dev-spi.c
> +++ b/arch/arm/mach-s3c64xx/dev-spi.c
> @@ -12,10 +12,10 @@
> ?#include <linux/string.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/dma.h>
> ?#include <mach/map.h>
> -#include <mach/gpio.h>
> ?#include <mach/gpio-bank-c.h>
> ?#include <mach/spi-clocks.h>
>
> diff --git a/arch/arm/mach-s3c64xx/gpiolib.c b/arch/arm/mach-s3c64xx/gpiolib.c
> index 60c929a..300dee4 100644
> --- a/arch/arm/mach-s3c64xx/gpiolib.c
> +++ b/arch/arm/mach-s3c64xx/gpiolib.c
> @@ -15,9 +15,9 @@
> ?#include <linux/kernel.h>
> ?#include <linux/irq.h>
> ?#include <linux/io.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/map.h>
> -#include <mach/gpio.h>
>
> ?#include <plat/gpio-core.h>
> ?#include <plat/gpio-cfg.h>
> diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
> index 8e28e44..0007368 100644
> --- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
> +++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
> @@ -15,9 +15,9 @@
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> ?#include <linux/fb.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/regs-fb.h>
> -#include <mach/gpio.h>
> ?#include <plat/fb.h>
> ?#include <plat/gpio-cfg.h>
>
> diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
> index d1b11e6..406192a 100644
> --- a/arch/arm/mach-s3c64xx/setup-i2c0.c
> +++ b/arch/arm/mach-s3c64xx/setup-i2c0.c
> @@ -14,10 +14,10 @@
>
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> +#include <linux/gpio.h>
>
> ?struct platform_device; /* don't need the contents */
>
> -#include <mach/gpio.h>
> ?#include <mach/gpio-bank-b.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
> diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
> index 2dce57d..1ee62c9 100644
> --- a/arch/arm/mach-s3c64xx/setup-i2c1.c
> +++ b/arch/arm/mach-s3c64xx/setup-i2c1.c
> @@ -14,10 +14,10 @@
>
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> +#include <linux/gpio.h>
>
> ?struct platform_device; /* don't need the contents */
>
> -#include <mach/gpio.h>
> ?#include <mach/gpio-bank-b.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
> diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
> index a58c0cc..dcf37e2 100644
> --- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
> @@ -16,8 +16,8 @@
> ?#include <linux/interrupt.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/io.h>
> +#include <linux/gpio.h>
>
> -#include <mach/gpio.h>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/sdhci.h>
>
> diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
> index 0c53679..3ca0d2b 100644
> --- a/arch/arm/mach-s5p6440/dev-audio.c
> +++ b/arch/arm/mach-s5p6440/dev-audio.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/audio.h>
>
> -#include <mach/gpio.h>
> ?#include <mach/map.h>
> ?#include <mach/dma.h>
> ?#include <mach/irqs.h>
> diff --git a/arch/arm/mach-s5p6440/dev-spi.c b/arch/arm/mach-s5p6440/dev-spi.c
> index 0a30280..510af44 100644
> --- a/arch/arm/mach-s5p6440/dev-spi.c
> +++ b/arch/arm/mach-s5p6440/dev-spi.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/dma.h>
> ?#include <mach/map.h>
> ?#include <mach/irqs.h>
> -#include <mach/gpio.h>
> ?#include <mach/spi-clocks.h>
>
> ?#include <plat/s3c64xx-spi.h>
> diff --git a/arch/arm/mach-s5p6440/gpio.c b/arch/arm/mach-s5p6440/gpio.c
> index 92efc05..8bf6e0c 100644
> --- a/arch/arm/mach-s5p6440/gpio.c
> +++ b/arch/arm/mach-s5p6440/gpio.c
> @@ -13,9 +13,11 @@
> ?#include <linux/kernel.h>
> ?#include <linux/irq.h>
> ?#include <linux/io.h>
> +#include <linux/gpio.h>
> +
> ?#include <mach/map.h>
> -#include <mach/gpio.h>
> ?#include <mach/regs-gpio.h>
> +
> ?#include <plat/gpio-core.h>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/gpio-cfg-helpers.h>
> diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
> index cb801e1..7a4e347 100644
> --- a/arch/arm/mach-s5p6442/dev-audio.c
> +++ b/arch/arm/mach-s5p6442/dev-audio.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/audio.h>
>
> -#include <mach/gpio.h>
> ?#include <mach/map.h>
> ?#include <mach/dma.h>
> ?#include <mach/irqs.h>
> diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
> index 3019952..e894651 100644
> --- a/arch/arm/mach-s5p6442/dev-spi.c
> +++ b/arch/arm/mach-s5p6442/dev-spi.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/dma.h>
> ?#include <mach/map.h>
> ?#include <mach/irqs.h>
> -#include <mach/gpio.h>
> ?#include <mach/spi-clocks.h>
>
> ?#include <plat/s3c64xx-spi.h>
> diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
> index 18cfe9a..a699ed6 100644
> --- a/arch/arm/mach-s5pc100/dev-audio.c
> +++ b/arch/arm/mach-s5pc100/dev-audio.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/audio.h>
>
> -#include <mach/gpio.h>
> ?#include <mach/map.h>
> ?#include <mach/dma.h>
> ?#include <mach/irqs.h>
> diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
> index 14618c3..a0ef7c3 100644
> --- a/arch/arm/mach-s5pc100/dev-spi.c
> +++ b/arch/arm/mach-s5pc100/dev-spi.c
> @@ -10,10 +10,10 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/dma.h>
> ?#include <mach/map.h>
> -#include <mach/gpio.h>
> ?#include <mach/spi-clocks.h>
>
> ?#include <plat/s3c64xx-spi.h>
> diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
> index 6e21533..21dc6cf 100644
> --- a/arch/arm/mach-s5pv210/dev-audio.c
> +++ b/arch/arm/mach-s5pv210/dev-audio.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/audio.h>
>
> -#include <mach/gpio.h>
> ?#include <mach/map.h>
> ?#include <mach/dma.h>
> ?#include <mach/irqs.h>
> diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
> index 337a62b..826cdbc 100644
> --- a/arch/arm/mach-s5pv210/dev-spi.c
> +++ b/arch/arm/mach-s5pv210/dev-spi.c
> @@ -10,11 +10,11 @@
>
> ?#include <linux/platform_device.h>
> ?#include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/dma.h>
> ?#include <mach/map.h>
> ?#include <mach/irqs.h>
> -#include <mach/gpio.h>
> ?#include <mach/spi-clocks.h>
>
> ?#include <plat/s3c64xx-spi.h>
> diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
> index a50cbac..928cf1f 100644
> --- a/arch/arm/mach-s5pv210/setup-fb-24bpp.c
> +++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
> @@ -13,9 +13,9 @@
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> ?#include <linux/fb.h>
> +#include <linux/gpio.h>
>
> ?#include <mach/regs-fb.h>
> -#include <mach/gpio.h>
> ?#include <mach/map.h>
> ?#include <plat/fb.h>
> ?#include <mach/regs-clock.h>
> diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
> index c718253..d38f7cb 100644
> --- a/arch/arm/mach-s5pv210/setup-i2c0.c
> +++ b/arch/arm/mach-s5pv210/setup-i2c0.c
> @@ -14,10 +14,10 @@
>
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> +#include <linux/gpio.h>
>
> ?struct platform_device; /* don't need the contents */
>
> -#include <mach/gpio.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
>
> diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
> index 45e0e6e..148bb78 100644
> --- a/arch/arm/mach-s5pv210/setup-i2c1.c
> +++ b/arch/arm/mach-s5pv210/setup-i2c1.c
> @@ -14,10 +14,10 @@
>
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> +#include <linux/gpio.h>
>
> ?struct platform_device; /* don't need the contents */
>
> -#include <mach/gpio.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
>
> diff --git a/arch/arm/mach-s5pv210/setup-i2c2.c b/arch/arm/mach-s5pv210/setup-i2c2.c
> index b11b4bf..2396cb8 100644
> --- a/arch/arm/mach-s5pv210/setup-i2c2.c
> +++ b/arch/arm/mach-s5pv210/setup-i2c2.c
> @@ -14,10 +14,10 @@
>
> ?#include <linux/kernel.h>
> ?#include <linux/types.h>
> +#include <linux/gpio.h>
>
> ?struct platform_device; /* don't need the contents */
>
> -#include <mach/gpio.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
>
> diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> index fe7d86d..6b73e71 100644
> --- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> +++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
> @@ -15,10 +15,10 @@
> ?#include <linux/interrupt.h>
> ?#include <linux/platform_device.h>
> ?#include <linux/io.h>
> +#include <linux/gpio.h>
> ?#include <linux/mmc/host.h>
> ?#include <linux/mmc/card.h>
>
> -#include <mach/gpio.h>
> ?#include <plat/gpio-cfg.h>
> ?#include <plat/regs-sdhci.h>
> ?#include <plat/sdhci.h>
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
