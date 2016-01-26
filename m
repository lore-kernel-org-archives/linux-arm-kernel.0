From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jan 2016 20:31:52 -0600
Subject: [PATCH V3 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <1453722989-41622-1-git-send-email-blogic@openwrt.org>
References: <1453722989-41622-1-git-send-email-blogic@openwrt.org>
Message-ID: <20160126023152.GA9464@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 12:56:28PM +0100, John Crispin wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree at vger.kernel.org
> ---
>  .../bindings/regulator/mt6323-regulator.txt        |  241 ++++++++++++++++++++
>  1 file changed, 241 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> new file mode 100644
> index 0000000..4412102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
> @@ -0,0 +1,241 @@
> +Mediatek MT6323 Regulator Driver
> +
> +Required properties:
> +- compatible: "mediatek,mt6323-regulator"
> +- mt6323regulator: List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  The definition for each of these nodes is defined using the standard binding
> +  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.

This is a node, not property and it should be named "regulators".

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
> +		mt6323regulator: mt6323regulator{
> +			compatible = "mediatek,mt6323-regulator";
> +
