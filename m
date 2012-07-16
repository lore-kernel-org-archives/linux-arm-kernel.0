From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jul 2012 17:43:34 -0500
Subject: [RFC PATCHv2 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA  Cyclone 5 HW
In-Reply-To: <1342113976-27140-3-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-3-git-send-email-dinguyen@altera.com>
Message-ID: <50049916.3080509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2012 12:26 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> - Mininum support for Altera's SOCFPGA Cyclone 5 hardware.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>

Two comments below, but otherwise:

Reviewed-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/boot/dts/socfpga.dtsi           |   73 ++++++++++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5.dts   |  118 ++++++++++++++++++++++++++++++
>  arch/arm/configs/socfpga_defconfig       |   83 +++++++++++++++++++++
>  arch/arm/mach-socfpga/Kconfig            |    7 ++
>  arch/arm/mach-socfpga/Makefile           |    6 ++
>  arch/arm/mach-socfpga/Makefile.boot      |    1 +
>  arch/arm/mach-socfpga/common.h           |    2 +-
>  arch/arm/mach-socfpga/socfpga_cyclone5.c |   60 +++++++++++++++

I don't think this patch split makes too much sense. I would put all but
the dts files and defconfig in the first patch.


> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> new file mode 100644
> index 0000000..133fc89
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -0,0 +1,7 @@
> +config MACH_SOCFPGA_CYCLONE5
> +       bool "SOCFPGA Cyclone5 platform"
> +       select COMMON_CLK
> +       select HAVE_SMP
> +       select PLAT_SOCFPGA_ETH
> +       help
> +         Include support for the Altera(R) Cyclone5 development platform.

You don't need a config option for a machine with DT.

Rob
