From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 04 Oct 2017 15:38:57 +1030
Subject: [PATCH 5/8] ARM: dts: aspeed-palmetto: Add I2C devices
In-Reply-To: <20170928075149.8154-6-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-6-joel@jms.id.au>
Message-ID: <1507093737.5452.14.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
> Enable the buses that are in use and the devices that are attached.
> Currently that includes the battery backed RTC, temperature
> measurement
> and EEPROM.
> 
> Some of these buses are for hotplugged cards, such as PCIe cards.
> Others do not yet have upstream drivers, so there are no devices
> attached.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> ?arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 48
> +++++++++++++++++++++++++++
> ?1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> index 112551766275..e387c80b7f4f 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> @@ -61,3 +61,51 @@
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&pinctrl_rmii1_default>;
> ?};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	eeprom at 50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +	};
> +
> +	rtc at 68 {
> +		compatible = "dallas,ds3231";
> +		reg = <0x68>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	tmp423 at 4c {
> +		compatible = "ti,tmp423";
> +		reg = <0x4c>;
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	status = "okay";
> +};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/49fcc8a9/attachment.sig>
