From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 11:02:47 +0200
Subject: [PATCH 4/4] arm64: dts: allwinner: h5: Add SID for H5
In-Reply-To: <20180723104255.94244-4-manu@freebsd.org>
References: <20180723104255.94244-1-manu@freebsd.org>
 <20180723104255.94244-4-manu@freebsd.org>
Message-ID: <20180724090247.uhvtnukrr5cevv2j@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 12:42:55PM +0200, Emmanuel Vadot wrote:
> The SID controller on H5 look the same as the one present in the A64.
> But in case we find some difference one day at a compatible string
> of it's own and a fallback to the A64 one.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  .../devicetree/bindings/nvmem/allwinner,sunxi-sid.txt        | 1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi                 | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index e319fe5e205a..99c4ba6a3f61 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -7,6 +7,7 @@ Required properties:
>    "allwinner,sun8i-a83t-sid"
>    "allwinner,sun8i-h3-sid"
>    "allwinner,sun50i-a64-sid"
> +  "allwinner,sun50i-h5-sid"
>  
>  - reg: Should contain registers location and length

Bindings patches should be separate.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> index 62d646baac3c..28183bf77164 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> @@ -129,3 +129,8 @@
>  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  	compatible = "allwinner,sun50i-h5-pinctrl";
>  };
> +
> +&sid {
> +	compatible = "allwinner,sun50i-h5-sid",
> +		     "allwinner,sun50i-a64-sid";
> +};

I'm not sure doing a split similar to what you're doing here just to
save the reg line is worth it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/368c7667/attachment.sig>
