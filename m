From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Mar 2012 10:54:13 +0100
Subject: [PATCH] ARM: davinci: implement DEBUG_LL port choice
In-Reply-To: <1331842703-4248-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1331842703-4248-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120320095413.GD15647@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Mar 15, 2012 at 09:18:23PM +0100, Uwe Kleine-K?nig wrote:
> Apart from the necessity to do this change for multi-platform kernels
> the previous logic depended on the zImage decompressor to write the
> physical and virtual address to a magic memory location.
> If the decompressor is unused or not correctly configured for the
> current machid, the addruart macro was an infinite loop. Moreover
> debugging the early zImage code was not possible either.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Kconfig.debug                           |   16 ++++++
>  arch/arm/mach-davinci/include/mach/debug-macro.S |   58 ++++++++--------------
>  arch/arm/mach-davinci/include/mach/hardware.h    |    2 +-
>  arch/arm/mach-davinci/include/mach/serial.h      |   10 ----
>  arch/arm/mach-davinci/include/mach/uncompress.h  |   25 +++-------
>  5 files changed, 44 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e0d236d..57019be 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -108,6 +108,22 @@ choice
>  		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
>  		depends on HAVE_AT91_DBGU1
>  
> +	config DEBUG_DAVINCI_UART0
> +		bool "Kernel low-level debugging on Davinci using uart0
> +		depends on ARCH_DAVINCI_DM644x
> +
> +	config DEBUG_DA8XX_UART1
> +		bool "Kernel low-level debugging on DA8xx using uart1"
> +		depends on ARCH_DAVINCI_DA8XX
> +
> +	config DEBUG_DA8XX_UART2
> +		bool "Kernel low-level debugging on DA8xx using uart2"
> +		depends on ARCH_DAVINCI_DA8XX
> +
> +	config DEBUG_TNETV107X_UART1
> +		bool "Kernel low-level debugging on TNETV107x using uart1
> +		depends on ARCH_DAVINCI_TNETV107X
> +
on the first and the last description line there are the closing "
missing. Should I resend?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
