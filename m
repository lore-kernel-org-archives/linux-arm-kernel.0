From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 26 May 2015 10:00:30 -0400
Subject: [PATCH] serial: samsung: only use earlycon for console
In-Reply-To: <3397068.2Doeo7zeZ1@wuerfel>
References: <3397068.2Doeo7zeZ1@wuerfel>
Message-ID: <55647C7E.6010907@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 04:26 PM, Arnd Bergmann wrote:
> A configuration that enables earlycon but not the core console
> code causes a link error:
> 
>   drivers/built-in.o: In function `setup_earlycon':
>   drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'
> 
> That error can be triggered by the newly added samsung earlycon support,
> which is missing a 'select' statement.
> 
> As suggested by Peter Hurley, solves the problem by moving the
> 'select SERIAL_EARLYCON' statement to the samsung console driver
> option, as it is done by all other console drivers.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
