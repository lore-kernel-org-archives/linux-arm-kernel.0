From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 15:42:08 +1030
Subject: [PATCH 6/8] ARM: dts: aspeed-ast2500: Add I2C devices
In-Reply-To: <20170928075149.8154-7-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-7-joel@jms.id.au>
Message-ID: <1507093928.5452.15.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
> Enable the buses that are in use and the devices that are attached.
> Currently that includes temperature measurement and EEPROM.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> ?arch/arm/boot/dts/aspeed-ast2500-evb.dts | 19 +++++++++++++++++++
> ?1 file changed, 19 insertions(+)
>?
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> index 7c90dac99822..dc7d73b02b76 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -59,3 +59,22 @@
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> ?};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c08";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +
> +	lm75 at 4d {
> +		compatible = "national,lm75";
> +		reg = <0x4d>;
> +	};
> +};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/e88d7abd/attachment.sig>
