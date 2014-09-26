From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 26 Sep 2014 13:47:03 +0200
Subject: [PATCHv3 2/7] ARM: at91: introduce basic SAMA5D4 support
In-Reply-To: <1410797759-18675-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410797759-18675-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410797759-18675-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1411732023.7866.15.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-15 at 18:15 +0200, Alexandre Belloni wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

This landed in next-20140926, as commit 2dc850b62e5b ("ARM: at91:
introduce basic SAMA5D4 support").

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index b11ad54f8d17..7b44db208f10 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -101,6 +101,10 @@ choice
>  		bool "Kernel low-level debugging on 9263 and 9g45"
>  		depends on HAVE_AT91_DBGU1
>  
> +	config AT91_DEBUG_LL_DBGU2
> +		bool "Kernel low-level debugging on sama5d4"
> +		depends on HAVE_AT91_DBGU2
> +

Why is this Kconfig symbol needed? Nothing in next-20140926 uses it. Are
future users perhaps queued somewhere (say, in commits that didn't
survive today's rather lively linux-next merges)?

>  	config DEBUG_BCM2835
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
>  		depends on ARCH_BCM2835


Paul Bolle
