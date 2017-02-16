From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 20:06:32 +0100
Subject: [PATCH 08/21] ARM: dts: sun8i-h3: add dwmac-sun8i rgmii pins
In-Reply-To: <20170216124859.14346-9-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
 <20170216124859.14346-9-clabbe.montjoie@gmail.com>
Message-ID: <20170216190632.hezcacn3hw5uhxcn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 01:48:46PM +0100, Corentin Labbe wrote:
> This patch add pinctrl node for dwmac-sun8i on H3.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 61d56d2..59ed40e 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -349,6 +349,17 @@
>  				function = "i2c2";
>  			};
>  
> +			emac_rgmii_pins: emac0 at 0 {
> +				allwinner,pins = "PD0", "PD1", "PD2", "PD3",
> +						"PD4", "PD5", "PD7",
> +						"PD8", "PD9", "PD10",
> +						"PD12", "PD13", "PD15",
> +						"PD16", "PD17";
> +				allwinner,function = "emac";

Please use the generic pin config properties (ie. pins and functions).

> +				allwinner,drive = <SUN4I_PINCTRL_40_MA>;

Why do you need to use 40mA?

> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;

This is the default now.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/27dd5072/attachment-0001.sig>
