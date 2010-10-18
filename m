From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 19:54:27 +0900
Subject: [PATCH 1/2] ARM: SAMSUNG: Add setname core function for S3C24XX
	NAND
In-Reply-To: <1279495911-17346-2-git-send-email-sbkim73@samsung.com>
References: <1279495911-17346-1-git-send-email-sbkim73@samsung.com>
	<1279495911-17346-2-git-send-email-sbkim73@samsung.com>
Message-ID: <048401cb6eb2$d7069d00$8513d700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch replaces the device name assignment method from string
assignment
> to set_name method for all s3c24xx machines and adds device core file.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s3c2412/s3c2412.c                |    3 +-
>  arch/arm/mach-s3c2416/s3c2416.c                |    3 +-
>  arch/arm/mach-s3c2440/s3c244x.c                |    3 +-
>  arch/arm/mach-s3c2443/s3c2443.c                |    3 +-
>  arch/arm/plat-samsung/include/plat/nand-core.h |   28
> ++++++++++++++++++++++++
>  5 files changed, 36 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/include/plat/nand-core.h
> 
> diff --git a/arch/arm/mach-s3c2412/s3c2412.c b/arch/arm/mach-
> s3c2412/s3c2412.c
> index bef39f7..4c6df51 100644
> --- a/arch/arm/mach-s3c2412/s3c2412.c
> +++ b/arch/arm/mach-s3c2412/s3c2412.c
> @@ -51,6 +51,7 @@
>  #include <plat/clock.h>
>  #include <plat/pm.h>
>  #include <plat/pll.h>
> +#include <plat/nand-core.h>
> 
>  #ifndef CONFIG_CPU_S3C2412_ONLY
>  void __iomem *s3c24xx_va_gpio2 = S3C24XX_VA_GPIO;
> @@ -92,7 +93,7 @@ void __init s3c2412_init_uarts(struct s3c2410_uartcfg
*cfg,
> int no)
>  	/* rename devices that are s3c2412/s3c2413 specific */
>  	s3c_device_sdi.name  = "s3c2412-sdi";
>  	s3c_device_lcd.name  = "s3c2412-lcd";
> -	s3c_device_nand.name = "s3c2412-nand";
> +	s3c_nand_setname("s3c2412-nand");
> 
>  	/* alter IRQ of SDI controller */
> 
> diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-
> s3c2416/s3c2416.c
> index 35dabcc..bfe674f 100644
> --- a/arch/arm/mach-s3c2416/s3c2416.c
> +++ b/arch/arm/mach-s3c2416/s3c2416.c
> @@ -55,6 +55,7 @@
>  #include <plat/cpu.h>
> 
>  #include <plat/iic-core.h>
> +#include <plat/nand-core.h>
> 
>  static struct map_desc s3c2416_iodesc[] __initdata = {
>  	IODESC_ENT(WATCHDOG),
> @@ -99,7 +100,7 @@ void __init s3c2416_init_uarts(struct s3c2410_uartcfg
*cfg,
> int no)
>  {
>  	s3c24xx_init_uartdevs("s3c2440-uart", s3c2410_uart_resources, cfg,
no);
> 
> -	s3c_device_nand.name = "s3c2416-nand";
> +	s3c_nand_setname("s3c2416-nand");
>  }
> 
>  /* s3c2416_map_io
> diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-
> s3c2440/s3c244x.c
> index 5e4a97e..90c1707 100644
> --- a/arch/arm/mach-s3c2440/s3c244x.c
> +++ b/arch/arm/mach-s3c2440/s3c244x.c
> @@ -44,6 +44,7 @@
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
>  #include <plat/pll.h>
> +#include <plat/nand-core.h>
> 
>  static struct map_desc s3c244x_iodesc[] __initdata = {
>  	IODESC_ENT(CLKPWR),
> @@ -68,7 +69,7 @@ void __init s3c244x_map_io(void)
> 
>  	s3c_device_sdi.name  = "s3c2440-sdi";
>  	s3c_device_i2c0.name  = "s3c2440-i2c";
> -	s3c_device_nand.name = "s3c2440-nand";
> +	s3c_nand_setname("s3c2440-nand");
>  	s3c_device_ts.name = "s3c2440-ts";
>  	s3c_device_usbgadget.name = "s3c2440-usbgadget";
>  }
> diff --git a/arch/arm/mach-s3c2443/s3c2443.c b/arch/arm/mach-
> s3c2443/s3c2443.c
> index ce2ec32..a64615e 100644
> --- a/arch/arm/mach-s3c2443/s3c2443.c
> +++ b/arch/arm/mach-s3c2443/s3c2443.c
> @@ -35,6 +35,7 @@
>  #include <plat/s3c2443.h>
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> +#include <plat/nand-core.h>
> 
>  static struct map_desc s3c2443_iodesc[] __initdata = {
>  	IODESC_ENT(WATCHDOG),
> @@ -61,7 +62,7 @@ int __init s3c2443_init(void)
> 
>  	s3c24xx_reset_hook = s3c2443_hard_reset;
> 
> -	s3c_device_nand.name = "s3c2412-nand";
> +	s3c_nand_setname("s3c2412-nand");
> 
>  	/* change WDT IRQ number */
>  	s3c_device_wdt.resource[1].start = IRQ_S3C2443_WDT;
> diff --git a/arch/arm/plat-samsung/include/plat/nand-core.h
b/arch/arm/plat-
> samsung/include/plat/nand-core.h
> new file mode 100644
> index 0000000..6de2078
> --- /dev/null
> +++ b/arch/arm/plat-samsung/include/plat/nand-core.h
> @@ -0,0 +1,28 @@
> +/* arch/arm/plat-samsung/include/plat/nand-core.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S3C -  Nand Controller core functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_NAND_CORE_H
> +#define __ASM_ARCH_NAND_CORE_H __FILE__
> +
> +/* These functions are only for use with the core support code, such as
> + * the cpu specific initialisation code
> + */
> +
> +/* re-define device name depending on support. */
> +static inline void s3c_nand_setname(char *name)
> +{
> +#ifdef CONFIG_S3C_DEV_NAND
> +	s3c_device_nand.name = name;
> +#endif
> +}
> +
> +#endif /* __ASM_ARCH_NAND_CORE_H */
> --

Ok...will apply.

Ben, if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
