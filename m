From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 09:40:43 -0600
Subject: [PATCH V4 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
Message-ID: <20160201154043.GA24185@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 01:00:58PM +0100, John Crispin wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree at vger.kernel.org
> 
> ---
> Changes in V4
> * regulator is a subnode and not a property
> 
> Changes in V3
> * fix the subject prefix
> 
>  .../bindings/regulator/mt6323-regulator.txt        |  244 ++++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

A few nits, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> new file mode 100644
> index 0000000..1ee3dd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> @@ -0,0 +1,244 @@
> +Mediatek MT6323 Regulator Driver
> +
> +Required properties:
> +- compatible: "mediatek,mt6323-regulator"
> +
> +All voltage regulators are defined as subnodes of the regulator drivers node.

s/drivers//

I believe the standard node name here is "regulators".

> +A list of regulators provided by this controller are defined as subnodes of
> +the drivers node. Each regulator is named according to its regulator type,
> +buck_<name> and ldo_<name>. The definition for each of these nodes is defined
> +using the standard binding for regulators at
> +Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +The valid names for regulators are::
> +BUCK:
> +  buck_vproc, buck_vsys, buck_vpa
> +LDO:
> +  ldo_vtcxo, ldo_vcn28, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_va, ldo_vcama,
> +  ldo_vio28, ldo_vusb, ldo_vmc, ldo_vmch, ldo_vemc3v3, ldo_vgp1, ldo_vgp2,
> +  ldo_vgp3, ldo_vcn18, ldo_vsim1, ldo_vsim2, ldo_vrtc, ldo_vcamaf, ldo_vibr,
> +  ldo_vrf18, ldo_vm, ldo_vio18, ldo_vcamd, ldo_vcamio
> +
> +Example:
> +
> +	pmic: mt6323 {
> +		compatible = "mediatek,mt6323";
> +
> +		mt6323regulator: regulator{

regulators and a space (i.e. "regulators {")

> +			compatible = "mediatek,mt6323-regulator";
> +
