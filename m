From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 06 Apr 2012 14:49:23 +0200
Subject: [PATCH] ARM: at91: remove empty at91_init_serial function
In-Reply-To: <1333715779-1485-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333715779-1485-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <4F7EE653.6010604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2012 02:36 PM, Joachim Eastwood :
> The real function is long gone and the empty one will generate warnings when configured without Atmel serial.
>   arch/arm/mach-at91/at91rm9200_devices.c:1176: warning: 'struct at91_uart_config' declared inside parameter list
>   arch/arm/mach-at91/at91rm9200_devices.c:1176: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

queue in at91-fixes for 3.4-rc

Thanks,

> ---
>  arch/arm/mach-at91/at91rm9200_devices.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index 99ce5c9..05774e5 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -1173,7 +1173,6 @@ void __init at91_add_device_serial(void)
>  		printk(KERN_INFO "AT91: No default serial console defined.\n");
>  }
>  #else
> -void __init __deprecated at91_init_serial(struct at91_uart_config *config) {}
>  void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
>  void __init at91_set_serial_console(unsigned portnr) {}
>  void __init at91_add_device_serial(void) {}


-- 
Nicolas Ferre
