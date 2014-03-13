From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Mar 2014 22:27:25 +0100
Subject: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140313212725.GF2696@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 4cc2f5f2ecad..c1fd510fd2c4 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -762,7 +762,7 @@
>  		};
>  
>  		i2c0: i2c at 01c2ac00 {
> -			compatible = "allwinner,sun4i-i2c";
> +			compatible = "allwinner,sun4i-a10-i2c";

I still wonder why there is no "allwinner,sun4i-a20-i2c" entry first
(even if there is no similar entry in the driver *yet*). From the
devicetree wiki [1]:

===

compatible is a list of strings. The first string in the list specifies
the exact device that the node represents in the form
"<manufacturer>,<model>". The following strings represent other devices
that the device is compatible with.

For example, the Freescale MPC8349 System on Chip (SoC) has a serial
device which implements the National Semiconductor ns16550 register
interface. The compatible property for the MPC8349 serial device should
therefore be: compatible = "fsl,mpc8349-uart", "ns16550". In this case,
fsl,mpc8349-uart specifies the exact device, and ns16550 states that it
is register-level compatible with a National Semiconductor 16550 UART.

Note: ns16550 doesn't have a manufacturer prefix purely for historical
reasons. All new compatible values should use the manufacturer prefix.

This practice allows existing device drivers to be bound to a newer
device, while still uniquely identifying the exact hardware.

===

[1] http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatible_Property
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/d1b25041/attachment.sig>
