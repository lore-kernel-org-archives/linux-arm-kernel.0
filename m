From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 08:58:08 +0900
Subject: [PATCH] serial: samsung: Add support 4M baudrate for samsung
 serial
In-Reply-To: <001b01cce24a$b01cb370$10561a50$%kim@samsung.com>
References: <001b01cce24a$b01cb370$10561a50$%kim@samsung.com>
Message-ID: <4FAEF910.902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/12 17:06, ??? wrote:
> At getting the baudrate, the max baudrate parameter value
> is changed to 4M.
> So samsung serial can support upto 4M baudrate.
> 
> Signed-off-by: Kyoungil Kim<ki0351.kim@samsung.com>
> ---
>   drivers/tty/serial/samsung.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index a6abe0c..513096d 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -701,7 +701,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>   	 * Ask the core to calculate the divisor for us.
>   	 */
> 
> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
> +	baud = uart_get_baud_rate(port, termios, old, 0, 4000000);
>   	quot = s3c24xx_serial_getclk(ourport, baud,&clk,&clk_sel);
>   	if (baud == 38400&&  (port->flags&  UPF_SPD_MASK) == UPF_SPD_CUST)
>   		quot = port->custom_divisor;

Kyoungil,

Is this available on all of Samsung serial?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
