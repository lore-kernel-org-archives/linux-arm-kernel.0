From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 May 2014 18:09:36 -0700
Subject: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <1398947374-3115-9-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
Message-ID: <20140503010936.GF4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 01, 2014 at 02:29:34PM +0200, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 58 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 58 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 64 ++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 58 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 65 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 64 ++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 58 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 59 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 59 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 59 ++++++++++++++++++++++
>  10 files changed, 602 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index fa746aea..57d3fb4 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,56 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +
> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupts = <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				acin-supply = <&reg_axp_ipsout>;
> +				vin2-supply = <&reg_axp_ipsout>;
> +				vin3-supply = <&reg_axp_ipsout>;
> +				ldo24in-supply = <&reg_axp_ipsout>;
> +				ldo3in-supply = <&reg_axp_ipsout>;
> +				ldo5in-supply = <&reg_axp_ipsout>;
> +
> +				regulators {
> +					x-powers,dcdc-freq = <1500>;
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-always-on;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-always-on;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-always-on;

Do all these regulators need to be always on? It makes sense for the
pll and vcore, but I don't get why the mic and hdmi regulators need
this.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/0db2e6a4/attachment.sig>
