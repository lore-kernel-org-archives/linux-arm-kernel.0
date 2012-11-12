From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 16:15:52 +0000
Subject: [PATCH v2 01/17] ARM: clps711x: Load serial driver from boards
In-Reply-To: <1352545136-29089-2-git-send-email-shc_work@mail.ru>
References: <1352545136-29089-1-git-send-email-shc_work@mail.ru>
 <1352545136-29089-2-git-send-email-shc_work@mail.ru>
Message-ID: <201211121615.52867.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index a0a6db5..06f0e91 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -516,22 +516,6 @@ static struct platform_driver clps711x_uart_driver = {
>  };
>  module_platform_driver(clps711x_uart_driver);
>  
> -static struct platform_device clps711x_uart_device = {
> -	.name	= UART_CLPS711X_NAME,
> -};
> -
> -static int __init uart_clps711x_init(void)
> -{
> -	return platform_device_register(&clps711x_uart_device);
> -}
> -module_init(uart_clps711x_init);
> -
> -static void __exit uart_clps711x_exit(void)
> -{
> -	platform_device_unregister(&clps711x_uart_device);
> -}
> -module_exit(uart_clps711x_exit);
> -
>  MODULE_AUTHOR("Deep Blue Solutions Ltd");
>  MODULE_DESCRIPTION("CLPS711X serial driver");
>  MODULE_LICENSE("GPL");

This does not apply. It seems this depends on a patch that is in Greg's tree
but not in the arm-soc tree. I've tried applying the other patches without
this one, but failed.

I've also tried leaving out this one hunk to see if everything else works,
but found another bug in patch 12.

Giving up for now. Please resend a series that actually applies and builds
on a well-defined base.

	Arnd
