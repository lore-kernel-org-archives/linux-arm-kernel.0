From: sourav.poddar@ti.com (Sourav Poddar)
Date: Sat, 1 Jun 2013 17:18:12 +0530
Subject: [PATCH] serial: omap: repair building without PM_SLEEP
In-Reply-To: <1844339.mxci2DdvBF@wuerfel>
References: <1844339.mxci2DdvBF@wuerfel>
Message-ID: <51A9DF7C.30303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
On Saturday 01 June 2013 02:48 PM, Arnd Bergmann wrote:
> A recent bug fix in 3.10, ddd85e225c "serial: omap: prevent runtime PM for
> "no_console_suspend"", introduced a regression from an obvious typo:
>
> drivers/tty/serial/omap-serial.c:1677:14: error: 'serial_omap_complete'
> 	undeclared here (not in a function)
>
> This changes the incorrectly added macro to the one that we need instead.
>
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> ---
> Please apply for 3.10-rc
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 393a8eb..1aaeca8 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1326,7 +1326,7 @@ static int serial_omap_resume(struct device *dev)
>   }
>   #else
>   #define serial_omap_prepare NULL
> -#define serial_omap_prepare NULL
> +#define serial_omap_complete NULL
>   #endif /* CONFIG_PM_SLEEP */
>
>   static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
>
Yes, this bug was noticed last week and a patch for it has already been 
posted to the
serial mailing list[1].
[1]: http://www.spinics.net/lists/linux-serial/msg09741.html
