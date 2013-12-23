From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 15:53:42 +0800
Subject: [PATCH 1/6] ARM: dts: imx27-phytec-phycore-som: Add NFC pin group
In-Reply-To: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
References: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131223075341.GD26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 11:11:37AM +0400, Alexander Shiyan wrote:
> This patch adds pin group fro NAND Flash Controller.

s/fro/for

I fixed it up and applied the series.

Shawn

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 6 ++++++
>  arch/arm/boot/dts/imx27-pingrp.h                | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> index 7087a4f..94ba726 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> @@ -201,10 +201,16 @@
>  		pinctrl_i2c2: i2c2grp {
>  			fsl,pins = <MX27_I2C2_PINGRP1>;
>  		};
> +
> +		pinctrl_nfc: nfcgrp {
> +			fsl,pins = <MX27_NFC_PINGRP1>;
> +		};
>  	};
>  };
>  
>  &nfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_nfc>;
>  	nand-bus-width = <8>;
>  	nand-ecc-mode = "hw";
>  	nand-on-flash-bbt;
> diff --git a/arch/arm/boot/dts/imx27-pingrp.h b/arch/arm/boot/dts/imx27-pingrp.h
> index edc1e90..61eb710 100644
> --- a/arch/arm/boot/dts/imx27-pingrp.h
> +++ b/arch/arm/boot/dts/imx27-pingrp.h
> @@ -85,6 +85,15 @@
>  	MX27_PAD_I2C2_SDA__I2C2_SDA 0x0 \
>  	MX27_PAD_I2C2_SCL__I2C2_SCL 0x0
>  
> +#define MX27_NFC_PINGRP1 \
> +	MX27_PAD_NFRB__NFRB 0x0 \
> +	MX27_PAD_NFCLE__NFCLE 0x0 \
> +	MX27_PAD_NFWP_B__NFWP_B 0x0 \
> +	MX27_PAD_NFCE_B__NFCE_B 0x0 \
> +	MX27_PAD_NFALE__NFALE 0x0 \
> +	MX27_PAD_NFRE_B__NFRE_B 0x0 \
> +	MX27_PAD_NFWE_B__NFWE_B 0x0
> +
>  #define MX27_OWIRE1_PINGRP1 \
>  	MX27_PAD_RTCK__OWIRE 0x0
>  
> -- 
> 1.8.3.2
> 
