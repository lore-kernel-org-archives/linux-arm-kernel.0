From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 11:29:00 +0200
Subject: [PATCH 2/2] ARM: dts: orange-pi-zero: enable SPI NOR
In-Reply-To: <20170519213550.8434-3-geomatsi@gmail.com>
References: <20170519213550.8434-1-geomatsi@gmail.com>
 <20170519213550.8434-3-geomatsi@gmail.com>
Message-ID: <20170522092900.7v2mg5zkbt6eclhr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On Sat, May 20, 2017 at 12:35:50AM +0300, Sergey Matyukevich wrote:
> Enable SPI NOR on orange-pi-zero board.
> 
> For more information see:
> - http://linux-sunxi.org/Orange_Pi_Zero#SPI_NOR_flash

Same remark here than on the first patch

> 
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index 34e4a5a80136..fe39e96cee65 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -177,3 +177,19 @@
>  	status = "okay";
>  	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
>  };
> +
> +&spi0 {
> +	status = "okay";
> +
> +	flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;

How do the other OPi Zero that doesn't have that SPI flash behave?

> +
> +		partition at 00000000 {
> +			reg = <0x00000000 0x200000>;	/* 2Mb */
> +		};

There's no need to create a first partition, this needs to be
user-defined.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/2c848e31/attachment.sig>
