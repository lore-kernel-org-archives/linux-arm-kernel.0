From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:52:00 +0100
Subject: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3 sid controller
In-Reply-To: <20180128232919.12639-15-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-15-embed3d@gmail.com>
Message-ID: <20180129095200.attg7cgvpifpchtn@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
> This patch enables the the sid controller in the H3. It can be used
> for thermal calibration data.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 3f83f6a27c74..9bb5cc29fec5 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,13 @@
>  		};
>  	};
>  
> +	soc {
> +		sid: eeprom at 1c14000 {
> +			compatible = "allwinner,sun8i-h3-sid";
> +			reg = <0x01c14000 0x400>;
> +		};
> +	};
> +

Shouldn't you also use a nvmem-cells property to the THS node?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/600ce523/attachment.sig>
