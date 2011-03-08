From: randy.dunlap@oracle.com (Randy Dunlap)
Date: Tue, 8 Mar 2011 10:47:57 -0800
Subject: [PATCH v3 7/7] tty: add pruss SUART driver
In-Reply-To: <1299592667-21367-8-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-8-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <20110308104757.0f75409b.randy.dunlap@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  8 Mar 2011 19:27:46 +0530 Subhasish Ghosh wrote:

> This patch adds support for the TTY compliant
> Soft-UART device emulated on PRUSS.
> 
> This patch depends on:
> davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS.
> 		https://patchwork.kernel.org/patch/615681/
> davinci: changed SRAM allocator to shared ram.
> 		https://patchwork.kernel.org/patch/549351/
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> ---
>  drivers/tty/serial/Kconfig             |   22 +
>  drivers/tty/serial/Makefile            |   10 +
>  drivers/tty/serial/pruss_suart.c       | 1058 +++++++++++++++++++
>  drivers/tty/serial/pruss_suart.h       | 1081 ++++++++++++++++++++
>  drivers/tty/serial/pruss_suart_api.c   | 1757 ++++++++++++++++++++++++++++++++
>  drivers/tty/serial/pruss_suart_utils.c |  391 +++++++
>  include/linux/serial_core.h            |    2 +
>  7 files changed, 4321 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/tty/serial/pruss_suart.c
>  create mode 100644 drivers/tty/serial/pruss_suart.h
>  create mode 100644 drivers/tty/serial/pruss_suart_api.c
>  create mode 100644 drivers/tty/serial/pruss_suart_utils.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 2b83346..14ea0a3 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1596,4 +1596,26 @@ config SERIAL_PCH_UART
>  	  This driver is for PCH(Platform controller Hub) UART of Intel EG20T
>  	  which is an IOH(Input/Output Hub) for x86 embedded processor.
>  	  Enabling PCH_DMA, this PCH UART works as DMA mode.
> +
> +#
> +# SUART Kernel Configuration
> +#
> +
> +config SERIAL_PRUSS_SUART
> +	depends on ARCH_DAVINCI && ARCH_DAVINCI_DA850
> +	select SERIAL_CORE
> +	tristate "PRUSS based SoftUART emulation on DA8XX"
> +	---help---
> +	This driver emulates upto eight different UARTs on the PRUSS.

	                     up to

> +	You may modify the NR_SUARTS macro in the driver to emulate
> +	less number of UARTS as per your requirement.
> +	If not sure, mark N

	             mark N.

> +
> +config PRUSS_SUART_MCASP
> +    int "McASP number"
> +    depends on ARCH_DAVINCI && ARCH_DAVINCI_DA830 && SERIAL_PRUSS_SUART
> +    default "0"
> +    ---help---
> +    Enter the McASP number to use with SUART (0, 1 or 2).
> +	You will need to recompile the kernel if this is changed.

The 2 help text lines should be indented the same.

>  endmenu


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
