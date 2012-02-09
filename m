From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 9 Feb 2012 19:28:31 +0530
Subject: [PATCH RFC] OMAP: serial: Remove the hardcode
 serial_omap_console_ports array.
In-Reply-To: <1328795296-22935-1-git-send-email-shubhrajyoti@ti.com>
References: <1328795296-22935-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAL8m4yU5KPqO11FY2Rwpuqns+EBtGuAMna0gxcYwK0QZ1fSjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2012 at 7:18 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently the array serial_omap_console_ports is hard coded to 4.
> Make it depend on the macro OMAP_MAX_HSUART_PORTS(which is 4) which
> the maximum uart count.
>
> Cc: Govindraj Raja <govindraj.raja@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Govindraj.R <govindraj.raja@ti.com>

> ---
> ?drivers/tty/serial/omap-serial.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 1c24269..c570696 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1021,7 +1021,7 @@ static int serial_omap_poll_get_char(struct uart_port *port)
>
> ?#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>
> -static struct uart_omap_port *serial_omap_console_ports[4];
> +static struct uart_omap_port *serial_omap_console_ports[OMAP_MAX_HSUART_PORTS];
>
> ?static struct uart_driver serial_omap_reg;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
