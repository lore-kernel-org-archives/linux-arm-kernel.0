From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 9 Jul 2012 12:25:38 +0200
Subject: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
Message-ID: <20120709102538.GD1296@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31:59PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Also extend the
> kirkwood DT support to supply the needed properties.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 +++++++++++++++++-
>  arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
>  arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
>  drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++++++++++++++++---
>  4 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..89ef899 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
>  
>  Required properties :
>  
> @@ -32,3 +32,36 @@ Examples:
>  		interrupts = <58>;
>  	};
>  
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg         : Offset and length of the register set for the device
> + - compatible  : should be "marvell,mv64xxx-i2c"
> + - interrupts  : the interrupt number
> + - frequency-m : m factor in baud rate calculation
> +
> +Recommended properties :
> +
> + - frequency-n : n factor in baud rate calculation
> + - timeout-ms  : How long to wait for a transaction to complete

The way we define the bus speed for i2c with DT is using "clock-frequency".
You should be able to derive the dividers from that? Adding custom
properties for every driver will hardly be maintainable.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120709/36034f52/attachment.sig>
