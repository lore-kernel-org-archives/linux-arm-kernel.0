From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Jun 2017 08:10:07 +0200
Subject: [PATCH 1/9] serial: Add common rs485 device tree parsing function
In-Reply-To: <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20170622061007.h76gk3hixp4ipyvr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:21:22PM +0200, Uwe Kleine-K?nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Several drivers have the same device tree parsing code. Create
> a common helper function for it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/Kconfig  |  4 ++++
>  drivers/tty/serial/Makefile |  2 ++
>  drivers/tty/serial/of.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h | 12 ++++++++++++
>  4 files changed, 63 insertions(+)
>  create mode 100644 drivers/tty/serial/of.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 5c8850f7a2a0..8baef5b95bed 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -14,6 +14,10 @@ config SERIAL_EARLYCON
>  	  the console before standard serial driver is probed. The console is
>  	  enabled when early_param is processed.
>  
> +config OF_SERIAL
> +	depends on SERIAL_CORE
> +	def_bool y

This probably also needs a dependency on some device tree option,
CONFIG_OF maybe?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
