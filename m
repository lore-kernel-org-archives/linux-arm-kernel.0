From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:38 +1300
Subject: [PATCH v3 4/6] ARM: dts: mvebu: Add binding for mv98dx3236-soc-id
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-5-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DFX server on the 98dx3236 and compatible SoCs has an ID register.
Add documentation and a binding for this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - new, split from driver

 .../devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt  | 14 ++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt b/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
new file mode 100644
index 000000000000..ed08cb126a83
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
@@ -0,0 +1,14 @@
+Marvell 98dx3236 SoC ID
+---------------------------------------------------------------
+
+Required properties:
+
+- compatible: Should be "marvell,mv98dx3236-soc-id".
+
+- reg: should be the register base and length as documented in the
+  datasheet for the Device ID Status
+
+soc-id at f8244 {
+	compatible = "marvell,mv98dx3236-soc-id";
+	reg = <0xf8244 0x4>;
+};
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 5e7245524d46..6b81f7363d53 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -264,6 +264,11 @@
 			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
 			reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
 
+			soc-id at f8244 {
+				compatible = "marvell,mv98dx3236-soc-id";
+				reg = <0xf8244 0x4>;
+			};
+
 			dfx_coredivclk: corediv-clock at f8268 {
 				compatible = "marvell,mv98dx3236-corediv-clock";
 				reg = <0xf8268 0xc>;
-- 
2.11.0.24.ge6920cf
