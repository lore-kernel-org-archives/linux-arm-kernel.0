From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 13 May 2016 09:35:18 +0100
Subject: [PATCH] serial: Make SERIAL_MPS2_UART depend on ARCH_MPS2
In-Reply-To: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
References: <1462906570-27684-1-git-send-email-geert+renesas@glider.be>
Message-ID: <573591C6.1070106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/16 19:56, Geert Uytterhoeven wrote:
> Enabling support for the UART on the ARM MPS2 platform only make sense
> when compiling for the ARM MPS2 platform, unless compile-testing.

What you said is true, but looking around (see SERIAL_STM32 for example)
I'm wondering what makes MPS2 so special flake?

I was under impression that architecture/board specific guard must have
only if we have something like

#include <asm/xyz.h>

or

#include <mach/xyz.h>

which is not a case for device-tree driven MPS2 uart.

I have no idea what is practice for such things, so would be grateful to
get it known.

Cheers
Vladimir

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index b84810aa8621d8b1..3def7478ca44f573 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1457,7 +1457,7 @@ config SERIAL_MPS2_UART_CONSOLE
>  
>  config SERIAL_MPS2_UART
>  	bool "MPS2 UART port"
> -	depends on ARM || COMPILE_TEST
> +	depends on ARCH_MPS2 || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  This driver support the UART ports on ARM MPS2.
> 
