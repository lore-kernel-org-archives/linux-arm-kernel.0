From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 02 Mar 2015 23:01:09 +0100
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
Message-ID: <1425333669.24292.124.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-02 at 23:25 +0530, Kedareswara rao Appana wrote:
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -425,6 +425,19 @@ config IMG_MDC_DMA
>  	help
>  	  Enable support for the IMG multi-threaded DMA controller (MDC).
>  
> +config XILINX_DMA
> +	tristate "Xilinx AXI DMA Engine"
> +	depends on (ARCH_ZYNQ || MICROBLAZE)
> +	select DMA_ENGINE
> +	help
> +	  Enable support for Xilinx AXI DMA Soft IP.
> +
> +	This engine provides high-bandwidth direct memory access
> +	between memory and AXI4-Stream type target peripherals.
> +	It has two stream interfaces/channels, Memory Mapped to
> +	Stream (MM2S) and Stream to Memory Mapped (S2MM) for the
> +	data transfers.
> +

How did you test this patch? On next-20150302, running x86_64, I got:

$ make ARCH=microblaze menuconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTCC  scripts/kconfig/lxdialog/checklist.o
  HOSTCC  scripts/kconfig/lxdialog/util.o
  HOSTCC  scripts/kconfig/lxdialog/inputbox.o
  HOSTCC  scripts/kconfig/lxdialog/textbox.o
  HOSTCC  scripts/kconfig/lxdialog/yesno.o
  HOSTCC  scripts/kconfig/lxdialog/menubox.o
  HOSTLD  scripts/kconfig/mconf
scripts/kconfig/mconf Kconfig
drivers/dma/Kconfig:436: syntax error
drivers/dma/Kconfig:435: unknown option "This"
drivers/dma/Kconfig:436: unknown option "between"
drivers/dma/Kconfig:437: unknown option "It"
drivers/dma/Kconfig:438: unknown option "Stream"
drivers/dma/Kconfig:439: unknown option "data"
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2

Caused by the invalid indentation used here. You should add two spaces
after the initial tab in lines 436 through 439.


Paul Bolle
