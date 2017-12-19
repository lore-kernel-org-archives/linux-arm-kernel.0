From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 19 Dec 2017 09:56:38 +0100
Subject: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
In-Reply-To: <7cf5ad02-6003-4222-a2cb-030ae613b337@myway.de>
References: <7cf5ad02-6003-4222-a2cb-030ae613b337@myway.de>
Message-ID: <20171219085638.GA21577@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 04, 2017 at 01:36:07PM +0100, Thomas Rohloff wrote:
> Devices like DCF77 receivers need the baud-rate to be as low as 50.
> 
> I have tested this on a Meson GXL device with uart_A.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Thomas Rohloff <v10lator@myway.de>
> ---
> drivers/tty/serial/meson_uart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index 07c0f98be3ac..e281ce5d101d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -362,7 +362,7 @@ static void meson_uart_set_termios(struct uart_port
> *port,
> 
> 	writel(val, port->membase + AML_UART_CONTROL);
> 
> -	baud = uart_get_baud_rate(port, termios, old, 9600, 4000000);
> +	baud = uart_get_baud_rate(port, termios, old, 50, 4000000);
> 	meson_uart_change_speed(port, baud);
> 
> 	port->read_status_mask = AML_UART_TX_FIFO_WERR;

This patch is corrupted (line-wrapped), and can not be applied.  Please
fix up and resend.

thanks,

greg k-h
