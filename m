From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat, 02 May 2015 19:48:54 -0300
Subject: [PATCH v2 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <1430168695-21248-2-git-send-email-manabian@gmail.com>
References: <1430168695-21248-1-git-send-email-manabian@gmail.com>
 <1430168695-21248-2-git-send-email-manabian@gmail.com>
Message-ID: <55455456.6010503@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/27/2015 06:04 PM, Joachim Eastwood wrote:
> Add support for NXP's LPC18xx (Cortex-M3) and LPC43xx (Cortex-M4)
> SoCs. These SoCs are NXP's high preformance MCU line and can run at
> clock speeds up to 180 MHz for LPC18xx and 204 MHz for LPC43xx.
> 
> LPC43xx is more or less a LPC18xx with a Cortex-M4F core and a few
> extra peripherals. The LPC43xx series also features one or two
> Cortex-M0 cores that can be used to offload the main M4 core.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  arch/arm/Kconfig                    | 20 ++++++++++++++++++++
>  arch/arm/Kconfig.debug              |  8 +++++---
>  arch/arm/Makefile                   |  1 +
>  arch/arm/mach-lpc18xx/Makefile      |  1 +
>  arch/arm/mach-lpc18xx/Makefile.boot |  3 +++
>  arch/arm/mach-lpc18xx/board-dt.c    | 22 ++++++++++++++++++++++
>  6 files changed, 52 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-lpc18xx/Makefile
>  create mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
>  create mode 100644 arch/arm/mach-lpc18xx/board-dt.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 45df48ba0b12..fba149165229 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -586,6 +586,26 @@ config ARCH_W90X900
>  	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
>  		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
>  
> +config ARCH_LPC18XX
> +	bool "NXP LPC18xx/LPC43xx"
> +	depends on !MMU
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARM_AMBA
> +	select ARM_NVIC
> +	select AUTO_ZRELADDR
> +	select CLKSRC_OF
> +	select COMMON_CLK
> +	select CPU_V7M
> +	select GENERIC_CLOCKEVENTS
> +	select NO_IOPORT_MAP
> +	select PINCTRL
> +	select SPARSE_IRQ
> +	select USE_OF
> +	help
> +	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
> +	  high performance microcontrollers.
> +
>  config ARCH_LPC32XX
>  	bool "NXP LPC32XX"
>  	select ARCH_REQUIRE_GPIOLIB
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 0c12ffb155a2..468202308adf 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1317,8 +1317,9 @@ config DEBUG_UART_8250
>  	def_bool ARCH_DOVE || ARCH_EBSA110 || \
>  		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
>  		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
> -		ARCH_IOP33X || ARCH_IXP4XX || \
> -		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
> +		ARCH_IOP33X || ARCH_IXP4XX || ARCH_LPC18XX || \
>  
Are you sure this change is needed?

I *think* it should be enough to select CONFIG_DEBUG_LL_UART_8250,
but don't have a board to test this for now (I will soon).

Other than that, it looks good:

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
