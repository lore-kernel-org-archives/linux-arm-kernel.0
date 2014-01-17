From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 17 Jan 2014 23:24:16 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAzLzhdIEFSTTogYnJjbXN0YjogYWRkIGRlYnVnIFVB?=
 =?UTF-8?B?UlQgZm9yIGVhcmx5cHJpbnRrIHN1cHBvcnQ=?=
In-Reply-To: <1389986367-4010-4-git-send-email-marc.ceeeee@gmail.com>
References: <1389986367-4010-1-git-send-email-marc.ceeeee@gmail.com>
 <1389986367-4010-4-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <1389986656.910825095@f427.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 17 ?????? 2014, 11:19 -08:00 ?? Marc Carino <marc.ceeeee@gmail.com>:
> Add the UART definitions needed to support earlyprintk on brcmstb machines.
> 
> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/Kconfig.debug |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 5765abf..266c699 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -94,6 +94,17 @@ choice
>  		depends on ARCH_BCM2835
>  		select DEBUG_UART_PL01X
>  
> +	config DEBUG_BRCMSTB_UART
> +		bool "Use BRCMSTB UART for low-level debug"
> +		depends on ARCH_BRCMSTB
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want the debug print routines to direct
> +		  their output to the first serial port on these devices.
> +
> +		  If you have a Broadcom STB chip and would like early print
> +		  messages to appear over the UART, select this option.
> +
>  	config DEBUG_CLPS711X_UART1
>  		bool "Kernel low-level debugging messages via UART1"
>  		depends on ARCH_CLPS711X
> @@ -988,6 +999,7 @@ config DEBUG_UART_PHYS
>  	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
>  	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
>  	default 0x20201000 if DEBUG_BCM2835
> +	default 0xf0406b00 if DEBUG_BRCMSTB_UART

This should be sorted by address.

---
