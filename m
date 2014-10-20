From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 21:43:25 +0200
Subject: [PATCH] ARM: debug: move StrongARM debug include to
 arch/arm/include/debug
In-Reply-To: <1413444696-25790-1-git-send-email-dbaryshkov@gmail.com>
References: <1413444696-25790-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <2298192.mGraIjK2LJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 October 2014 11:31:36 Dmitry Eremin-Solenikov wrote:
> StrongARM debug-macro.S is quite standalone thing, depending only on
> register mappings. Move it to proper place and add Kconfig entry.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Looks good to me in principle. Russell, are you ok with us picking this
up through arm-soc?

>  arch/arm/Kconfig.debug                                         |  9 +++++++++
>  .../include/mach/debug-macro.S => include/debug/sa1100.S}      | 10 ++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>  rename arch/arm/{mach-sa1100/include/mach/debug-macro.S => include/debug/sa1100.S} (83%)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54..8adf043 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -547,6 +547,14 @@ choice
>                   Say Y here if you want kernel low-level debugging support
>                   on PXA UART1.
>  
> +       config DEBUG_SA1100
> +               depends on ARCH_SA1100
> +               bool "Use SA1100 UARTs for low-level debug"
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on SA-11x0 UART ports. The kernel will check for the first
> +                 enabled UART in a sequence 3-1-2.
> +
>         config DEBUG_REALVIEW_STD_PORT
>                 bool "RealView Default UART"
>                 depends on ARCH_REALVIEW

Note that the symbols are ordered alphabetically. Please fix this.

	Arnd
