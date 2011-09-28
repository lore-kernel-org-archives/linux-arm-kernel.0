From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 28 Sep 2011 10:27:10 +0200
Subject: [PATCH for 3.1] ARM: at91: add PWM driver selector in Kconfig
	for 9g45 family
In-Reply-To: <1316710934-22405-1-git-send-email-nicolas.ferre@atmel.com>
References: <1316710934-22405-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4E82DA5E.6070906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/09/2011 19:02, Nicolas Ferre :
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/misc/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 2d6423c..7ce658e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -63,7 +63,7 @@ config AD525X_DPOT_SPI
>  
>  config ATMEL_PWM
>  	tristate "Atmel AT32/AT91 PWM support"
> -	depends on AVR32 || ARCH_AT91SAM9263 || ARCH_AT91SAM9RL || ARCH_AT91CAP9
> +	depends on AVR32 || ARCH_AT91SAM9263 || ARCH_AT91SAM9RL || ARCH_AT91SAM9G45 || ARCH_AT91CAP9

I am rethinking about that just planning to remove entirely this "depends" line...

>  	help
>  	  This option enables device driver support for the PWM channels
>  	  on certain Atmel processors.  Pulse Width Modulation is used for

---8<--------
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 28 Sep 2011 09:38:44 +0200
Subject: [PATCH for 3.1 V2] ARM: at91: add PWM driver selector in Kconfig for 9g45 family

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2d6423c..7ce658e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -63,7 +63,6 @@ config AD525X_DPOT_SPI
 
 config ATMEL_PWM
 	tristate "Atmel AT32/AT91 PWM support"
-	depends on AVR32 || ARCH_AT91SAM9263 || ARCH_AT91SAM9RL || ARCH_AT91CAP9
 	help
 	  This option enables device driver support for the PWM channels
 	  on certain Atmel processors.  Pulse Width Modulation is used for

-- 
Nicolas Ferre
