From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 05 Oct 2017 10:05:03 +1030
Subject: [PATCH v2 4/9] ARM: dts: aspeed-romulus: Add I2C devices
In-Reply-To: <20171004064917.2498-5-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
 <20171004064917.2498-5-joel@jms.id.au>
Message-ID: <1507160103.5452.35.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 17:19 +1030, Joel Stanley wrote:
> Enable the buses that are in use and the devices that are attached.
> Currently that is just the battery backed RTC.
>?
> Some of these buses are for hotplugged cards, such as PCIe cards. Others
> do not yet have upstream drivers, so there are no devices attached.
>?
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> v2:
> ?- Use okay not enabled for the status
> ---
> ?arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 54 ++++++++++++++++++++++++++++
> ?1 file changed, 54 insertions(+)
>?
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> index 1190fec1b5d0..8b96baf7c4de 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -79,3 +79,57 @@
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&pinctrl_rmii1_default>;
> ?};
> +
> +&i2c2 {
> +	status = "okay";
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
> +	/* PCIe slot 1 (x8) */
> +	status = "okay";
> +};
> +
> +&i2c7 {
> +	/* PCIe slot 2 (x16) */
> +	status = "okay";
> +};
> +
> +&i2c8 {
> +	/* PCIe slot 3 (x16) */
> +	status = "okay";
> +};
> +
> +&i2c9 {
> +	/* PCIe slot 4 (x16) */
> +	status = "okay";
> +};
> +
> +&i2c10 {
> +	/* PCIe slot 5 (x8) */
> +	status = "okay";
> +};
> +
> +&i2c11 {
> +	status = "okay";
> +
> +	rtc at 32 {
> +		compatible = "epson,rx8900";
> +		reg = <0x32>;
> +	};
> +};
> +
> +&i2c12 {
> +	status = "okay";
> +};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/0c718a9d/attachment.sig>
