From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Nov 2014 12:39:11 -0600
Subject: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under
 drivers
In-Reply-To: <1416594856-15201-4-git-send-email-tony@atomide.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com>
 <1416594856-15201-4-git-send-email-tony@atomide.com>
Message-ID: <20141121183911.GA7508@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 10:34:16AM -0800, Tony Lindgren wrote:
> Just move to drivers as further clean-up can now happen there
> finally.
> 
> Let's also add Roger and me to the MAINTAINERS so we get
> notified for any patches related to GPMC.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  MAINTAINERS                                              | 8 ++++++++
>  arch/arm/mach-omap2/Kconfig                              | 2 ++
>  arch/arm/mach-omap2/Makefile                             | 2 +-
>  drivers/memory/Kconfig                                   | 8 ++++++++
>  drivers/memory/Makefile                                  | 1 +
>  arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c | 0
>  6 files changed, 20 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-omap2/gpmc.c => drivers/memory/omap-gpmc.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dab92a7..78cc059 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6629,6 +6629,14 @@ L:	linux-omap at vger.kernel.org
>  S:	Maintained
>  F:	sound/soc/omap/
>  
> +OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT
> +M:	Roger Quadros <rogerq@ti.com>
> +M:	Tony Lindgren <tony@atomide.com>
> +L:	linux-omap at vger.kernel.org
> +S:	Maintained
> +F:	drivers/memory/omap-gpmc.c
> +F:	arch/arm/mach-omap2/*gpmc*
> +
>  OMAP FRAMEBUFFER SUPPORT
>  M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
>  L:	linux-fbdev at vger.kernel.org
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f4d06ae..0ea218e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -79,7 +79,9 @@ config ARCH_OMAP2PLUS
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select MACH_OMAP_GENERIC
> +	select MEMORY
>  	select OMAP_DM_TIMER
> +	select OMAP_GPMC
>  	select PINCTRL
>  	select SOC_BUS
>  	select TI_PRIV_EDMA
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3e824f8..bd85741 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -6,7 +6,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
>  	-I$(srctree)/arch/arm/plat-omap/include
>  
>  # Common support
> -obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o gpmc.o timer.o pm.o \
> +obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
>  	 common.o gpio.o dma.o wd_timer.o display.o i2c.o hdq1w.o omap_hwmod.o \
>  	 omap_device.o sram.o drm.o
>  
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 6d91c27..6759de7 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -41,6 +41,14 @@ config TI_EMIF
>  	  parameters and other settings during frequency, voltage and
>  	  temperature changes
>  
> +config OMAP_GPMC
> +	bool

shouldn't you make this selectable ? I might want to build a kernel
without GPMC support because my board just doesn't use GPMC :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/ea451d7f/attachment.sig>
