From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 29 Oct 2013 12:15:54 +0200
Subject: [PATCH 1/3] ARM: dts: omap4-panda: add DPI pinmuxing
In-Reply-To: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <526F8ADA.3030003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 25/10/13 13:07, Tomi Valkeinen wrote:
> New u-boot versions no longer set the pinmuxing for Panda's DPI output,
> and the muxing has to be done in the .dts file.
> 
> Add pinmuxing for DPI and TFP410. Without these, the DVI output on Panda
> does not work with recent u-boot.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

The two latter patches in this series needs more work and can be
dropped, but this one should be applied to make Panda work properly with
new u-boots.

 Tomi

> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi | 43 +++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index faa95b5..fcb8856 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -129,6 +129,8 @@
>  			&twl6040_pins
>  			&mcpdm_pins
>  			&mcbsp1_pins
> +			&dss_dpi_pins
> +			&tfp410_pins
>  			&dss_hdmi_pins
>  			&tpd12s015_pins
>  			&hsusbb1_pins
> @@ -166,6 +168,47 @@
>  		>;
>  	};
>  
> +	dss_dpi_pins: pinmux_dss_dpi_pins {
> +		pinctrl-single,pins = <
> +			0x122 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data23 */
> +			0x124 (PIN_OUTPUT | MUX_MODE5) 	/* dispc2_data22 */
> +			0x126 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data21 */
> +			0x128 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data20 */
> +			0x12a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data19 */
> +			0x12c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data18 */
> +			0x12e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data15 */
> +			0x130 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data14 */
> +			0x132 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data13 */
> +			0x134 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data12 */
> +			0x136 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data11 */
> +
> +			0x174 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data10 */
> +			0x176 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data9 */
> +			0x178 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data16 */
> +			0x17a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data17 */
> +			0x17c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_hsync */
> +			0x17e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_pclk */
> +			0x180 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_vsync */
> +			0x182 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_de */
> +			0x184 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data8 */
> +			0x186 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data7 */
> +			0x188 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data6 */
> +			0x18a (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data5 */
> +			0x18c (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data4 */
> +			0x18e (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data3 */
> +
> +			0x190 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data2 */
> +			0x192 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data1 */
> +			0x194 (PIN_OUTPUT | MUX_MODE5)	/* dispc2_data0 */
> +		>;
> +	};
> +
> +	tfp410_pins: pinmux_tfp410_pins {
> +		pinctrl-single,pins = <
> +			0x144 (PIN_OUTPUT | MUX_MODE3)	/* gpio_0 */
> +		>;
> +	};
> +
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins = <
>  			0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/e5ad093b/attachment.sig>
