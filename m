From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 19 Dec 2015 20:39:37 -0500
Subject: [PATCH] serial: atmel: remove module device table
In-Reply-To: <1540393.QjMdSgnH0N@wuerfel>
References: <1540393.QjMdSgnH0N@wuerfel>
Message-ID: <20151220013937.GC2772@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH] serial: atmel: remove module device table] On 18/12/2015 (Fri 15:49) Arnd Bergmann wrote:

> A recent patch removed most of the module-specific code from the atmel
> serial driver, but left the MODULE_DEVICE_TABLE in place, so we can't
> build it any more:
> 
> drivers/tty/serial/atmel_serial.c:192:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
> drivers/tty/serial/atmel_serial.c:192:1: warning: parameter names (without types) in function declaration
> 
> This removes the table as well to avoid the error.

I sent the same fix on Thursday.  Again, sorry that my testing did
not uncover this earlier.  I was build testing for ARM on almost a daily
basis but not so regularly for MIPS.

http://lkml.kernel.org/r/1450364746-815-1-git-send-email-paul.gortmaker at windriver.com

Paul.
--

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 50e785a0ea73..1c0884d8ef32 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -188,8 +188,6 @@ static const struct of_device_id atmel_serial_dt_ids[] = {
>  	{ .compatible = "atmel,at91sam9260-usart" },
>  	{ /* sentinel */ }
>  };
> -
> -MODULE_DEVICE_TABLE(of, atmel_serial_dt_ids);
>  #endif
>  
>  static inline struct atmel_uart_port *
> 
