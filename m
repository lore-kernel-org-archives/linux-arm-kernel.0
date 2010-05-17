From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 22:23:50 +0900
Subject: [PATCH 02/15] ARM: Samsung: move common I2C0 device helpers to
	machine	directories
In-Reply-To: <1273817946-29404-3-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <004901caf5c4$343341d0$9c99c570$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---

See your new 2nd patch of 'Common plat-s5p fixes patch set'.

>  arch/arm/mach-s5p6440/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c |    2 +-
>  arch/arm/mach-s5p6442/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c |    2 +-
>  arch/arm/mach-s5pv210/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5pv210}/setup-i2c0.c |   10 +++++-----
>  arch/arm/plat-s5p/Makefile                       |    1 -
>  7 files changed, 10 insertions(+), 8 deletions(-)
>  copy arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c (92%)
>  copy arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c (92%)
>  rename arch/arm/{plat-s5p => mach-s5pv210}/setup-i2c0.c (69%)
> 
> diff --git a/arch/arm/mach-s5p6440/Makefile
b/arch/arm/mach-s5p6440/Makefile
> index 1ad894b..9646cdf 100644
> --- a/arch/arm/mach-s5p6440/Makefile
> +++ b/arch/arm/mach-s5p6440/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core support for S5P6440 system
> 
>  obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o
> +obj-$(CONFIG_CPU_S5P6440)	+= setup-i2c0.o
> 
>  # machine support
> 
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c
b/arch/arm/mach-s5p6440/setup-i2c0.c
> similarity index 92%
> copy from arch/arm/plat-s5p/setup-i2c0.c
> copy to arch/arm/mach-s5p6440/setup-i2c0.c
> index 67a66e0..69e8a66 100644
> --- a/arch/arm/plat-s5p/setup-i2c0.c
> +++ b/arch/arm/mach-s5p6440/setup-i2c0.c
> @@ -1,4 +1,4 @@
> -/* linux/arch/arm/plat-s5p/setup-i2c0.c
> +/* linux/arch/arm/mach-s5p6440/setup-i2c0.c
>   *
>   * Copyright (c) 2009 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
> diff --git a/arch/arm/mach-s5p6442/Makefile
b/arch/arm/mach-s5p6442/Makefile
> index dde39a6..4942c14 100644
> --- a/arch/arm/mach-s5p6442/Makefile
> +++ b/arch/arm/mach-s5p6442/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core support for S5P6442 system
> 
>  obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o
> +obj-$(CONFIG_CPU_S5P6442)	+= setup-i2c0.o
> 
>  # machine support
> 
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c
b/arch/arm/mach-s5p6442/setup-i2c0.c
> similarity index 92%
> copy from arch/arm/plat-s5p/setup-i2c0.c
> copy to arch/arm/mach-s5p6442/setup-i2c0.c
> index 67a66e0..662695d 100644
> --- a/arch/arm/plat-s5p/setup-i2c0.c
> +++ b/arch/arm/mach-s5p6442/setup-i2c0.c
> @@ -1,4 +1,4 @@
> -/* linux/arch/arm/plat-s5p/setup-i2c0.c
> +/* linux/arch/arm/mach-s5p6442/setup-i2c0.c
>   *
>   * Copyright (c) 2009 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
> diff --git a/arch/arm/mach-s5pv210/Makefile
b/arch/arm/mach-s5pv210/Makefile
> index 8ebf51c..1a972a5 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core support for S5PV210 system
> 
>  obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
> +obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
> 
>  # machine support
> 
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c
b/arch/arm/mach-s5pv210/setup-i2c0.c
> similarity index 69%
> rename from arch/arm/plat-s5p/setup-i2c0.c
> rename to arch/arm/mach-s5pv210/setup-i2c0.c
> index 67a66e0..27de0c1 100644
> --- a/arch/arm/plat-s5p/setup-i2c0.c
> +++ b/arch/arm/mach-s5pv210/setup-i2c0.c
> @@ -1,11 +1,11 @@
> -/* linux/arch/arm/plat-s5p/setup-i2c0.c
> +/*
> + * linux/arch/arm/mach-s5pv210/setup-i2c2.c
>   *
> - * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> + * Copyright 2009 Samsung Electronics Co.
>   *
> - * I2C0 GPIO configuration.
> + * Base S5PV210 I2C bus 0 gpio configuration
>   *
> - * Based on plat-s3c64xx/setup-i2c0.c
> + * Based on mach-s3c64xx/setup-i2c0.c
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index a7c54b3..0ec09a9 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -16,4 +16,3 @@ obj-y				+= dev-uart.o
>  obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= irq.o
> -obj-y				+= setup-i2c0.o
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
