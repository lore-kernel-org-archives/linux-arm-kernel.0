From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  8 Sep 2015 15:50:27 -0700
Subject: [PATCH net-next 2/2] dtb: xgene: Add 2nd 10GbE node
In-Reply-To: <1441752627-9326-1-git-send-email-isubramanian@apm.com>
References: <1441752627-9326-1-git-send-email-isubramanian@apm.com>
Message-ID: <1441752627-9326-3-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the second 10GbE dt node for APM X-Gene SoC device tree

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index d831bc2..d483e7e 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -207,6 +207,17 @@
 				clock-output-names = "xge0clk";
 			};
 
+			xge1clk: xge1clk at 1f62c000 {
+				compatible = "apm,xgene-device-clock";
+				status = "disabled";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f62c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				csr-mask = <0x3>;
+				clock-output-names = "xge1clk";
+			};
+
 			sataphy1clk: sataphy1clk at 1f21c000 {
 				compatible = "apm,xgene-device-clock";
 				#clock-cells = <1>;
@@ -816,6 +827,23 @@
 			phy-connection-type = "xgmii";
 		};
 
+		xgenet1: ethernet at 1f620000 {
+			compatible = "apm,xgene1-xgenet";
+			status = "disabled";
+			reg = <0x0 0x1f620000 0x0 0xd100>,
+			      <0x0 0x1f600000 0x0 0Xc300>,
+			      <0x0 0x18000000 0x0 0X8000>;
+			reg-names = "enet_csr", "ring_csr", "ring_cmd";
+			interrupts = <0x0 0x6C 0x4>,
+				     <0x0 0x6D 0x4>;
+			port-id = <1>;
+			dma-coherent;
+			clocks = <&xge1clk 0>;
+			/* mac address will be overwritten by the bootloader */
+			local-mac-address = [00 00 00 00 00 00];
+			phy-connection-type = "xgmii";
+		};
+
 		rng: rng at 10520000 {
 			compatible = "apm,xgene-rng";
 			reg = <0x0 0x10520000 0x0 0x100>;
-- 
1.9.1
