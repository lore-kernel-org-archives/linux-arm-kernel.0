From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 14:09:29 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419204028.GU10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <517173C0.6010902@ti.com>
 <20130419194323.GP10155@atomide.com>
 <201304192211.13356.arnd@arndb.de>
 <20130419204028.GU10155@atomide.com>
Message-ID: <20130419210929.GX10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [130419 13:47]:
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -5,8 +5,12 @@
>  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
>  
> +obj-y := id.o control.o
> +
> +ifeq ($(CONFIG_SOC_OMAP),y)
> +
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
> +obj-y := io.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o
>  

And the second obj-y needs to have += instead of := to build real configs :)

Tony
