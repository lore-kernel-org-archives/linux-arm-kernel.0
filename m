From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 31 May 2011 14:40:45 -0600
Subject: [PATCH] gpio: ep93xx: move driver to drivers/gpio
In-Reply-To: <201105311249.30372.hartleys@visionengravers.com>
References: <201105311249.30372.hartleys@visionengravers.com>
Message-ID: <BANLkTimzWyhZ14ieo0SUfsn8SKp9cM_EBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 1:49 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> The GPIO driver should reside in drivers/gpio.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
>
> ---
>
> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
> index 33ee2c8..6b7c41d 100644
> --- a/arch/arm/mach-ep93xx/Makefile
> +++ b/arch/arm/mach-ep93xx/Makefile
> @@ -1,7 +1,7 @@
> ?#
> ?# Makefile for the linux kernel.
> ?#
> -obj-y ? ? ? ? ? ? ? ? ?:= core.o clock.o dma-m2p.o gpio.o
> +obj-y ? ? ? ? ? ? ? ? ?:= core.o clock.o dma-m2p.o
> ?obj-m ? ? ? ? ? ? ? ? ?:=
> ?obj-n ? ? ? ? ? ? ? ? ?:=
> ?obj- ? ? ? ? ? ? ? ? ? :=
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 342d634..7307302 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -86,6 +86,13 @@ config GPIO_IT8761E
> ? ? ? ?help
> ? ? ? ? ?Say yes here to support GPIO functionality of IT8761E super I/O chip.
>
> +config GPIO_EP93XX
> + ? ? ? bool "Cirrus EP93xx GPIO support"
> + ? ? ? depends on ARCH_EP93XX
> + ? ? ? default y
> + ? ? ? help
> + ? ? ? ? Say yes here to support the Cirrus EP93xx GPIO peripheral.
> +

Do you really want a user-visible Kconfig symbol here?  If it cannot
be built as a module, then I suspect that for most on-chip gpio
controllers they should just be enabled unconditionally on the SoC's
Kconfig symbol.

g.
