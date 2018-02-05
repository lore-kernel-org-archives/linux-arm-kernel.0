From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 5 Feb 2018 13:36:02 +0100
Subject: [PATCH] [PATCH] tty/serial: atmel: add new version check for usart
In-Reply-To: <20180129113954.12011-1-jonas@orbital-systems.com>
References: <20180129113954.12011-1-jonas@orbital-systems.com>
Message-ID: <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/2018 at 12:39, Jonas Danielsson wrote:
> On our at91sam9260 based board the usart0 and usart1 ports report
> their versions (ATMEL_US_VERSION) as 0x10302. This version is not
> included in the current checks in the driver.
> 
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

It must be the AT91SAM9260 rev. B SoC, isn't it?

Thanks for your patch.

Best regards,
  Nicolas

> ---
>  drivers/tty/serial/atmel_serial.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index efa25611ca0c..ae9f1dcbf3fc 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1734,6 +1734,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  		switch (version) {
>  		case 0x302:
>  		case 0x10213:
> +		case 0x10302:
>  			dev_dbg(port->dev, "This version is usart\n");
>  			atmel_port->has_frac_baudrate = true;
>  			atmel_port->has_hw_timer = true;
> 


-- 
Nicolas Ferre
