From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 10 Dec 2014 15:07:53 +0100
Subject: [PATCH RFC 12/15] ARM: dts: imx6qdl-sabresd: Add support for
 TRULY TFT480800-16-E MIPI DSI panel
In-Reply-To: <1418200648-32656-13-git-send-email-Ying.Liu@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
 <1418200648-32656-13-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20141210140751.GF23558@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 04:37:25PM +0800, Liu Ying wrote:
[...]
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
[...]
> +&mipi_dsi {
> +	status = "okay";
> +
> +	panel at 0 {
> +		compatible = "himax,hx8369a-dsi";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_mipi_panel>;
> +		reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
> +		reset-delay = <120>;
> +		bs2-gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
> +		data-lanes = <2>;
> +		panel-width-mm = <45>;
> +		panel-height-mm = <76>;
> +		bs = <10>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&timing1>;
> +			timing1: truly-tft480800-16-e {

This is the only place where Truly is mentioned. The panel vendor is
either Truly or it is Himax, it can't be a mix. From this example and
your patch description it seems like Truly is the manufacturer of the
panel, hence the panel compatible should really be:

	compatible = "truly,tft480800-16-e";

That it uses an HX8369A chip internally is really secondary, at least
regarding the binding. If we ever get need to support multiple panels
with the same driver IC the proper solution would be to abstract that
code out into a helper library that is used from the various panel
drivers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141210/ee9b2376/attachment.sig>
