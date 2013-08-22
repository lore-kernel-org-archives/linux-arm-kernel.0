From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Aug 2013 18:22:43 +0200
Subject: [PATCH v6 3/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
In-Reply-To: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130822162241.GC31704@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -5,6 +5,8 @@ Required properties :
>  
>   - reg             : Offset and length of the register set for the device
>   - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
> +                     or for controller which support the I2C Transaction
> +                     Generator "marvell,mv64xxx-i2c","marvell,mv7230-i2c"

Too complicated IMO:
+			or "marvell,mv7230-i2c".

DT creators don't need to know about transaction generators. They just
supply the compatible string and the driver knows the details.

> +For a controller which support the I2C Transaction Generator:

"For the Armada XP" - there might be later IP cores on later SoC with
transaction generators and different errata. They will just get a new
compatible and the driver know the details.

> +
> +	i2c at 11000 {
> +		compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +		reg = <0x11000 0x100>;
> +		interrupts = <29>;
> +		clock-frequency = <100000>;
> +	};
> -- 
> 1.8.1.2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/bf59dad4/attachment.sig>
