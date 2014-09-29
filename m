From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 15:39:23 +0200
Subject: [PATCH 1/6] Documentation: DT: Add bindings for Spreadtrum serial
In-Reply-To: <1411992293-7729-2-git-send-email-zhang.lyra@gmail.com>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-2-git-send-email-zhang.lyra@gmail.com>
Message-ID: <5399512.qxHSYW7FgQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 20:04:48 zhang.lyra at gmail.com wrote:
> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
> index 7705477..a0bb1d1 100644
> --- a/Documentation/devicetree/bindings/serial/of-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/of-serial.txt
> @@ -14,6 +14,7 @@ Required properties:
>         - "altr,16550-FIFO32"
>         - "altr,16550-FIFO64"
>         - "altr,16550-FIFO128"
> +       - "sprd,serial"
>         - "serial" if the port type is unknown.
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> 

This file is really only for 8250 compatible UART implementations, please
add a new file with a proper binding for your serial port. It would be
nice if you could rename this file to 8250.txt to avoid confusing the
next person.

Please also add the "sprd" prefix to
Documentation/devicetree/bindings/vendor-prefixes.txt

	Arnd
