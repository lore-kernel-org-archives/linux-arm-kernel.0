From: phdm@macqel.be (Philippe De Muyter)
Date: Mon, 31 May 2010 16:21:23 +0200
Subject: [PATCH] General fixes in the serial_rs485 structure
In-Reply-To: <4C03BC19.5060402@evidence.eu.com>
References: <4BFE66CA.5050500@evidence.eu.com>
	<20100529000839.158dedd3@lxorguk.ukuu.org.uk>
	<4C0375C1.5030305@evidence.eu.com>
	<20100531113429.5efd6de9@lxorguk.ukuu.org.uk>
	<4C03BC19.5060402@evidence.eu.com>
Message-ID: <20100531142122.GA2571@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 03:39:37PM +0200, Claudio Scordino wrote:

> diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
> index eed3c2d..1adb1bf 100644
> --- a/drivers/serial/atmel_serial.c
> +++ b/drivers/serial/atmel_serial.c
> @@ -216,7 +216,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>  		dev_dbg(port->dev, "Setting UART to RS485\n");
>  		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
> -		UART_PUT_TTGR(port, rs485conf->delay_rts_before_send);
> +		UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
>  		mode |= ATMEL_US_USMODE_RS485;
>  	} else {
>  		dev_dbg(port->dev, "Setting UART to RS232\n");

Should the usage of delay_rts_after_send not depend on
(flags & SER_RS485_RTS_AFTER_SEND) also ?

and likewise with delay_rts_before_send and SER_RS485_RTS_BEFORE_SEND ?

Philippe

-- 
Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
