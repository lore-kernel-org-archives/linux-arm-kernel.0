From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 15:32:45 +0200
Subject: [PATCH] arm: zynq: Add device-type property for zynq ethernet phy
 nodes
Message-ID: <4ad09fa434f85861fd5f2dfcb7780b4076f9c53b.1500557562.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Mention device-type = "ethernet-phy", as qemu will need this in absence
of compatible.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-parallella.dts | 1 +
 arch/arm/boot/dts/zynq-zc702.dts      | 1 +
 arch/arm/boot/dts/zynq-zc706.dts      | 1 +
 arch/arm/boot/dts/zynq-zed.dts        | 1 +
 arch/arm/boot/dts/zynq-zybo.dts       | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 64a6390fc501..77f6f10bf685 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -54,6 +54,7 @@
 		compatible = "ethernet-phy-id0141.0e90",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
+		device_type = "ethernet-phy";
 		marvell,reg-init = <0x3 0x10 0xff00 0x1e>,
 		                   <0x3 0x11 0xfff0 0xa>;
 	};
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 2f99500faae5..a096275d903d 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -97,6 +97,7 @@
 
 	ethernet_phy: ethernet-phy at 7 {
 		reg = <7>;
+		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 7283037ce9cb..689ec9d6f7b9 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -53,6 +53,7 @@
 
 	ethernet_phy: ethernet-phy at 7 {
 		reg = <7>;
+		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 35e631d86b12..c6a5749c8930 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -50,6 +50,7 @@
 
 	ethernet_phy: ethernet-phy at 0 {
 		reg = <0>;
+		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index e19b58155d82..8b42fb199a8e 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -51,6 +51,7 @@
 
 	ethernet_phy: ethernet-phy at 0 {
 		reg = <0>;
+		device_type = "ethernet-phy";
 	};
 };
 
-- 
1.9.1
