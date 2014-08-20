From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 20 Aug 2014 08:56:59 -0700
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing Ethernet phys to Zynq DTs.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-zc702.dts | 6 ++++++
 arch/arm/boot/dts/zynq-zc706.dts | 6 ++++++
 arch/arm/boot/dts/zynq-zed.dts   | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 30bcfe20f0bc..fa810505ab8f 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -36,6 +36,12 @@
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 7 {
+		compatible = "marvell,88e1116r", "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 3d9cb023e158..d446b44d45a2 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -33,6 +33,12 @@
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 7 {
+		compatible = "marvell,88e1116r", "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 42deb1b7dbc8..92662eb078ce 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -33,6 +33,12 @@
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy>;
+
+	ethernet_phy: ethernet-phy at 0 {
+		compatible = "marvell,88e1518", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
 };
 
 &sdhci0 {
-- 
2.0.1.1.gfbfc394
