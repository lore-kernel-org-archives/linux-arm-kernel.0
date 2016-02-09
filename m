From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 16:26:38 +0100
Subject: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
In-Reply-To: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
Message-ID: <4571887.rTPndCnv20@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> It can not be used to check if an unsigned int reflects an error.
> Doing so can result in the following build warning.
> 
> drivers/tty/serial/digicolor-usart.c: In function ?digicolor_uart_probe?:
> include/linux/err.h:21:38: warning:
>         comparison is always false due to limited range of data type
> drivers/tty/serial/digicolor-usart.c:485:6: note:
>         in expansion of macro ?IS_ERR_VALUE?
> 
> If that warning is seen, an error return from platform_get_irq() is missed.
> 
> 

The patch looks correct to me, but what compiler version and which kernel
tree is it that triggered the warning?

Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and the
changes are still under discussion, but I don't see that warning with
any of the versions.

	Arnd
