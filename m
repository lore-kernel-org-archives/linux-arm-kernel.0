From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Nov 2013 15:59:33 +0800
Subject: [PATCH 2/2] ARM: dts: imx27-phytec-phycore-som: Update FEC node
In-Reply-To: <1384069921-15270-2-git-send-email-shc_work@mail.ru>
References: <1384069921-15270-1-git-send-email-shc_work@mail.ru>
 <1384069921-15270-2-git-send-email-shc_work@mail.ru>
Message-ID: <20131111075932.GH10085@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 10, 2013 at 11:52:01AM +0400, Alexander Shiyan wrote:
> This patch updates FEC devicetree node of Phytec PCM038 module:
> - Adding missing phy_mode properties.
> - Adding dummy regulator to provide functionality without

s/dummy/fixed

>   dummy-regulator in the kernel.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> index 4ec402c..317df5e 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
> @@ -19,6 +19,20 @@
>  	memory {
>  		reg = <0xa0000000 0x08000000>;
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_3v3: 3v3 {

		reg_3v3: regulator at 0 {

Shawn

> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
>  };
>  
>  &audmux {
> @@ -134,7 +148,9 @@
>  };
>  
>  &fec {
> +	phy-mode = "mii";
>  	phy-reset-gpios = <&gpio3 30 0>;
> +	phy-supply = <&reg_3v3>;
>  	status = "okay";
>  };
>  
> -- 
> 1.8.1.5
> 
