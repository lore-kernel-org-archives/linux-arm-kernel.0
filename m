From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 16:58:58 +0200
Subject: [PATCH 5/9] ARM: dts: sun7i: cubieboard2: Enable SPI0
In-Reply-To: <a5a061d98b7ff851866cc668cd8bf8f6fc99d002.1440080122.git.hramrach@gmail.com>
References: <cover.1440080122.git.hramrach@gmail.com>
 <a5a061d98b7ff851866cc668cd8bf8f6fc99d002.1440080122.git.hramrach@gmail.com>
Message-ID: <20150820145858.GX30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
> Only SPI0 is enabled. The schematic denotes it as the only SPI bus.
> Other SPI pins are reserved for different peripherals.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>

What device is connected to the other end?

> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 39a51d5..9861304 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -198,6 +198,13 @@
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins_a>,
> +		    <&spi0_cs0_pins_a>;
> +	status = "okay";
> +};
> +

You should probably add an alias to that bus too.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/5f89b1a8/attachment-0001.sig>
