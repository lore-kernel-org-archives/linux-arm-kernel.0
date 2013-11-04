From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Nov 2013 14:56:27 +0100
Subject: [PATCH v4 4/4] ARM: new platform for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <1383562853-17202-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201311041456.27654.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 November 2013, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Kconfig                 |  19 +++++++-
>  arch/arm/Makefile                |   1 +
>  arch/arm/configs/efm32_defconfig | 102 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-efm32/Makefile     |   1 +
>  arch/arm/mach-efm32/dtmachine.c  |  15 ++++++
>  5 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/configs/efm32_defconfig
>  create mode 100644 arch/arm/mach-efm32/Makefile
>  create mode 100644 arch/arm/mach-efm32/dtmachine.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 7ae0615..d8145fe 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -413,6 +413,23 @@ config ARCH_EBSA110
>           Ethernet interface, two PCMCIA sockets, two serial ports and a
>           parallel port.
>  
> +config ARCH_EFM32
> +       bool "Energy Micro efm32"
> +       depends on !MMU
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARM_NVIC
> +       select CLKSRC_MMIO
> +       select CLKSRC_OF
> +       select COMMON_CLK
> +       select CPU_V7M
> +       select GENERIC_CLOCKEVENTS
> +       select NO_DMA
> +       select NO_IOPORT
> +       select SPARSE_IRQ
> +       select USE_OF
> +       help
> +         Support for Energy Micro's (now Silicon Labs) efm32 processors.
> +

It would be good to have at least in either the changeset description or the Kconfig
text (or both) some description about the platform: which SoCs have been tested,
what is this platform used for, where can one find data sheets etc.

	Arnd
