From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 19:50:51 +0100
Subject: [PATCH 3/5] regulator: axp20x: Update the bindings to use a
 local parent regulator
In-Reply-To: <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
 <1401297069-7423-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140528185051.GB22488@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 07:11:07PM +0200, Maxime Ripard wrote:

>  		axp_vcore_reg: dcdc2 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_ddr_reg: dcdc3 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_rtc_reg: ldo1 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_analog_reg: ldo2 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_pll_reg: ldo3 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_hdmi_reg: ldo4 {
> +			vin-supply = <&axp_ipsout_reg>;

>  		axp_mic_reg: ldo5 {
> +			vin-supply = <&axp_ipsout_reg>;

This is saying that every single regulator on the device is powered by a
(presumably) single input called "vin".  This would certainly be an
unusual package design...  As ever the name of the supply should follow
the name of the pin on the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/742d1fba/attachment.sig>
