From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 10:54:49 +0200
Subject: [PATCH v6 2/6] clk: sunxi-ng: Add sun4i/sun7i CCU driver
In-Reply-To: <f03e50040dc2d3dc3edd6be071510feeb953161d.1500043741.git-series.plaes@plaes.org>
References: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
 <f03e50040dc2d3dc3edd6be071510feeb953161d.1500043741.git-series.plaes@plaes.org>
Message-ID: <20170717085449.runn4azmedh2kgwy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 14, 2017 at 05:49:24PM +0300, Priit Laes wrote:
> Introduce a clock controller driver for sun4i A10 and sun7i A20
> series SoCs.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig              |   13 +-
>  drivers/clk/sunxi-ng/Makefile             |    1 +-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c      | 1454 ++++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.h      |   61 +-
>  include/dt-bindings/clock/sun4i-a10-ccu.h |  200 +++-
>  include/dt-bindings/clock/sun7i-a20-ccu.h |   53 +-
>  include/dt-bindings/reset/sun4i-a10-ccu.h |   69 +-
>  7 files changed, 1851 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
>  create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 7342928..1b5cea9 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -11,6 +11,19 @@ config SUN50I_A64_CCU
>  	default ARM64 && ARCH_SUNXI
>  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
>  
> +config SUNXI_A10_CCU
> +	bool "Support for the Allwinner A10/A20 CCU"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_MULT
> +	select SUNXI_CCU_NK
> +	select SUNXI_CCU_NKM
> +	select SUNXI_CCU_NM
> +	select SUNXI_CCU_MP
> +	select SUNXI_CCU_PHASE
> +	default MACH_SUN4I
> +	default MACH_SUN7I
> +	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST

I'm a bit late on this one, but I agree with Olliver, it should be
called SUN4I_A10. This is what we do for all the other symbols (and it
should be ordered as such).

> +
>  config SUN5I_CCU
>  	bool "Support for the Allwinner sun5i family CCM"
>  	default MACH_SUN5I
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0c45fa5..01e958c 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -21,6 +21,7 @@ lib-$(CONFIG_SUNXI_CCU)		+= ccu_mp.o
>  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
>  obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> +obj-$(CONFIG_SUNXI_A10_CCU)	+= ccu-sun4i-a10.o

The ordering is wrong here too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/8a0c31fb/attachment.sig>
