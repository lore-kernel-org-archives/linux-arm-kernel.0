From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 7 Nov 2018 13:47:03 +0100
Subject: [PATCH] arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx
 supply
In-Reply-To: <1541434917-18126-1-git-send-email-narmstrong@baylibre.com>
References: <1541434917-18126-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1b209a7e-e69a-079c-51e1-67b18410e5a0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2018 17:21, Neil Armstrong wrote:
> The hdmi_5v regulator must be enabled to provide power to the physical HDMI
> PHY and enables the HDMI 5V presence loopback for the monitor.
> 
> Fixes: b409f625a6d5 ("ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts   | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts         | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index 765247b..eb8eec8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -125,6 +125,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> index d32cf38..69c28c4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
> @@ -78,6 +78,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 90a56af..86a7be8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -155,6 +155,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> index 5896e8a..8a39d95 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -51,6 +51,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 313f88f..50d2be1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -271,6 +271,7 @@
>  	status = "okay";
>  	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
>  	pinctrl-names = "default";
> +	phy-supply = <&hdmi_5v>;
>  };
>  
>  &hdmi_tx_tmds_port {
> 


Oops, it should be hdmi_supply...

I'll resend..

neil
