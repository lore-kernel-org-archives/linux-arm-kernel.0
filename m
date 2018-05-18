From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 18 May 2018 10:11:41 +0200
Subject: [PATCH] ARM64: dts: sun50i: a64: Add spi flash node for sopine
In-Reply-To: <20180517150613.11916-1-manu@freebsd.org>
References: <20180517150613.11916-1-manu@freebsd.org>
Message-ID: <20180518081141.itlc4pelwkkpfvtv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 17, 2018 at 05:06:13PM +0200, Emmanuel Vadot wrote:
> The Sopine and Pine64-LTS have a winbond w25q128 spi flash on spi0.
> Add a node for it.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> index 43418bd881d8..3285aebc06d9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> @@ -66,6 +66,18 @@
>  	};
>  };
>  
> +&spi0  {
> +	status = "okay";
> +
> +	flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "w25q128", "jedec,spi-nor";

This applies to this patch and your previous Orange Pi PC2 one, but
the part name must have a vendor. Or you can drop it entirely if the
SPI-NOR driver can auto-detect it properly.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/f22030f4/attachment.sig>
