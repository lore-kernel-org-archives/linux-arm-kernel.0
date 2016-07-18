From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jul 2016 13:46:45 +0100
Subject: Applied "regulator: Add document for MT6323 regulator" to the
 regulator tree
In-Reply-To: <1468845651-64011-1-git-send-email-john@phrozen.org>
Message-ID: <E1bP7wb-0001p5-BP@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: Add document for MT6323 regulator

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d236b3ee5bb13f53ed60ccc6f704a13b923d2952 Mon Sep 17 00:00:00 2001
From: John Crispin <john@phrozen.org>
Date: Mon, 18 Jul 2016 14:40:50 +0200
Subject: [PATCH] regulator: Add document for MT6323 regulator

Signed-off-by: John Crispin <john@phrozen.org>
Cc: devicetree at vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/mt6323-regulator.txt        | 237 +++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6323-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
new file mode 100644
index 000000000000..c35d878b0960
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
@@ -0,0 +1,237 @@
+Mediatek MT6323 Regulator Driver
+
+All voltage regulators are defined as subnodes of the regulators node. A list
+of regulators provided by this controller are defined as subnodes of the
+PMIC's node. Each regulator is named according to its regulator type,
+buck_<name> and ldo_<name>. The definition for each of these nodes is defined
+using the standard binding for regulators at
+Documentation/devicetree/bindings/regulator/regulator.txt.
+
+The valid names for regulators are::
+BUCK:
+  buck_vproc, buck_vsys, buck_vpa
+LDO:
+  ldo_vtcxo, ldo_vcn28, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_va, ldo_vcama,
+  ldo_vio28, ldo_vusb, ldo_vmc, ldo_vmch, ldo_vemc3v3, ldo_vgp1, ldo_vgp2,
+  ldo_vgp3, ldo_vcn18, ldo_vsim1, ldo_vsim2, ldo_vrtc, ldo_vcamaf, ldo_vibr,
+  ldo_vrf18, ldo_vm, ldo_vio18, ldo_vcamd, ldo_vcamio
+
+Example:
+
+	pmic: mt6323 {
+		mt6323regulator: regulators {
+			mt6323_vproc_reg: buck_vproc{
+				regulator-name = "vproc";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <12500>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vsys_reg: buck_vsys{
+				regulator-name = "vsys";
+				regulator-min-microvolt = <1400000>;
+				regulator-max-microvolt = <2987500>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vpa_reg: buck_vpa{
+				regulator-name = "vpa";
+				regulator-min-microvolt = < 500000>;
+				regulator-max-microvolt = <3650000>;
+			};
+
+			mt6323_vtcxo_reg: ldo_vtcxo{
+				regulator-name = "vtcxo";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <90>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcn28_reg: ldo_vcn28{
+				regulator-name = "vcn28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_vcn33_bt_reg: ldo_vcn33_bt{
+				regulator-name = "vcn33_bt";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_vcn33_wifi_reg: ldo_vcn33_wifi{
+				regulator-name = "vcn33_wifi";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-enable-ramp-delay = <185>;
+			};
+
+			mt6323_va_reg: ldo_va{
+				regulator-name = "va";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcama_reg: ldo_vcama{
+				regulator-name = "vcama";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vio28_reg: ldo_vio28{
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vusb_reg: ldo_vusb{
+				regulator-name = "vusb";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-boot-on;
+			};
+
+			mt6323_vmc_reg: ldo_vmc{
+				regulator-name = "vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vmch_reg: ldo_vmch{
+				regulator-name = "vmch";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vemc3v3_reg: ldo_vemc3v3{
+				regulator-name = "vemc3v3";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+				regulator-boot-on;
+			};
+
+			mt6323_vgp1_reg: ldo_vgp1{
+				regulator-name = "vgp1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vgp2_reg: ldo_vgp2{
+				regulator-name = "vgp2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vgp3_reg: ldo_vgp3{
+				regulator-name = "vgp3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vcn18_reg: ldo_vcn18{
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vsim1_reg: ldo_vsim1{
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vsim2_reg: ldo_vsim2{
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vrtc_reg: ldo_vrtc{
+				regulator-name = "vrtc";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcamaf_reg: ldo_vcamaf{
+				regulator-name = "vcamaf";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vibr_reg: ldo_vibr{
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <36>;
+			};
+
+			mt6323_vrf18_reg: ldo_vrf18{
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1825000>;
+				regulator-max-microvolt = <1825000>;
+				regulator-enable-ramp-delay = <187>;
+			};
+
+			mt6323_vm_reg: ldo_vm{
+				regulator-name = "vm";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vio18_reg: ldo_vio18{
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6323_vcamd_reg: ldo_vcamd{
+				regulator-name = "vcamd";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+
+			mt6323_vcamio_reg: ldo_vcamio{
+				regulator-name = "vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <216>;
+			};
+		};
+	};
-- 
2.8.1
