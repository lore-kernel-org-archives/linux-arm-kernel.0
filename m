From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 14:46:19 +0200
Subject: [PATCH] arm64: dts: marvell: enable additional PCIe ports on Armada
 8040 DB
Message-ID: <20170928124619.11564-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 8040 DB has numerous PCIe ports, so let's enable a few more
of those PCIe ports that are enabled in the default bootloader
configuration.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 0d7b2ae46610..f971d445f1fb 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -141,6 +141,10 @@
 	status = "okay";
 };
 
+/* CON6 on CP0 expansion */
+&cpm_pcie0 {
+	status = "okay";
+};
 
 /* CON5 on CP0 expansion */
 &cpm_pcie2 {
@@ -206,6 +210,16 @@
 	phy-mode = "rgmii-id";
 };
 
+/* CON6 on CP1 expansion */
+&cps_pcie0 {
+	status = "okay";
+};
+
+/* CON7 on CP1 expansion */
+&cps_pcie1 {
+	status = "okay";
+};
+
 /* CON5 on CP1 expansion */
 &cps_pcie2 {
 	status = "okay";
-- 
2.13.5
