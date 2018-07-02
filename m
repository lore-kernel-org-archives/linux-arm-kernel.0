From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 2 Jul 2018 10:43:19 +0200
Subject: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
In-Reply-To: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stable Maintainers,

On 05/06/2018 10:52, Neil Armstrong wrote:
> Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> devices on the P212 Reference Design based boards.
> 
> Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

This commit hit Linus master with commit sha d511b3e4087eedbe11c7496c396432b8b7c2d7d9
Can this fix be applied to 4.17 stable kernel ?

Thanks,
Neil

>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 0cfd701..a1b3101 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -189,3 +189,10 @@
>  &usb0 {
>  	status = "okay";
>  };
> +
> +&usb2_phy0 {
> +	/*
> +	 * HDMI_5V is also used as supply for the USB VBUS.
> +	 */
> +	phy-supply = <&hdmi_5v>;
> +};
> 
