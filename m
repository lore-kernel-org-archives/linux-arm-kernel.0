From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 19 May 2010 03:26:33 +0100
Subject: [PATCH 1/2] ARM: Samsung: copy common I2C0 device helpers to
	machine directories
In-Reply-To: <1274178216-12003-2-git-send-email-m.szyprowski@samsung.com>
References: <1274178216-12003-1-git-send-email-m.szyprowski@samsung.com>
	<1274178216-12003-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100519022633.GO26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:23:35PM +0200, Marek Szyprowski wrote:
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

ok, will apply this with the condition that was think about
the proliferation of similar platform devices throughout the
system.

> ---
>  arch/arm/mach-s5p6440/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c |    2 +-
>  arch/arm/mach-s5p6442/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c |    2 +-
>  arch/arm/mach-s5pv210/Makefile                   |    1 +
>  arch/arm/{plat-s5p => mach-s5pv210}/setup-i2c0.c |    2 +-
>  arch/arm/plat-s5p/Makefile                       |    1 -
>  7 files changed, 6 insertions(+), 4 deletions(-)
>  copy arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c (92%)
>  copy arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c (92%)
>  rename arch/arm/{plat-s5p => mach-s5pv210}/setup-i2c0.c (92%)
> 
> diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
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
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/mach-s5p6440/setup-i2c0.c
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
> diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
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
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/mach-s5p6442/setup-i2c0.c
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
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
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
> diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
> similarity index 92%
> rename from arch/arm/plat-s5p/setup-i2c0.c
> rename to arch/arm/mach-s5pv210/setup-i2c0.c
> index 67a66e0..9ec6845 100644
> --- a/arch/arm/plat-s5p/setup-i2c0.c
> +++ b/arch/arm/mach-s5pv210/setup-i2c0.c
> @@ -1,4 +1,4 @@
> -/* linux/arch/arm/plat-s5p/setup-i2c0.c
> +/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
>   *
>   * Copyright (c) 2009 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
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
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
