From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 30 Oct 2015 09:30:21 -0400
Subject: [PATCH v2] serial: 8250_uniphier: add earlycon support
In-Reply-To: <1446173176-6966-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446173176-6966-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <563370ED.7040105@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2015 10:46 PM, Masahiro Yamada wrote:
> This reuses the code of drivers/tty/serial/8250/8250_early.c except
>
>    - Overwrite device->port.iotype and device->port.regshift for
>      UPIO_MEM32 because of_setup_earlycon() has set them for UPIO_MEM.
>
>    - Set device->baud to zero to prevent early8250_setup() from
>      initializing the divisor register because port->uartclk does not
>      match the frequency expected by this hardware.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
