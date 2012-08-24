From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 12:07:14 -0700
Subject: [PATCH v3 01/23] serial: omap: define and use to_uart_omap_port()
In-Reply-To: <1345717983-18179-2-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-2-git-send-email-balbi@ti.com>
Message-ID: <20120824190713.GP11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120823 03:37]:
> current code only works because struct uart_port
> is the first member on the uart_omap_port structure.
> 
> If, for whatever reason, someone puts another
> member as the first of the structure, that cast
> won't work anymore. In order to be safe, let's use
> a container_of() which, for now, gets optimized into
> a cast anyway.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |  2 ++
>  drivers/tty/serial/omap-serial.c              | 36 +++++++++++++--------------
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 1a52725..f3b35d9 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -137,4 +137,6 @@ struct uart_omap_port {
>  	struct work_struct	qos_work;
>  };
>  
> +#define to_uart_omap_port(p)	((container_of((p), struct uart_omap_port, port)))
> +
>  #endif /* __OMAP_SERIAL_H__ */

For the arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>

FYI, note that there are ARM SoC patches to move various header files to
live under include/linux/platform_data which may cause conflicts with these
changes.

Regards,

Tony
