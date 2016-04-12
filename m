From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:13:01 -0500
Subject: [PATCH 6/6] ARM: dts: Add Arria10 Ethernet EDAC devicetree entry
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-7-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree entries needed to support the Altera Ethernet
FIFO buffer EDAC on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 27cc497..6195ade 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -617,6 +617,42 @@
 				compatible = "altr,socfpga-a10-ocram-ecc";
 				reg = <0xff8c3000 0x400>;
 			};
+
+			emac0-rx-ecc at ff8c0800 {
+				compatible = "altr,socfpga-a10-emac0-rx-ecc";
+				reg = <0xff8c0800 0x400>;
+				parent = <&gmac0>;
+			};
+
+			emac0-tx-ecc at ff8c0c00 {
+				compatible = "altr,socfpga-a10-emac0-tx-ecc";
+				reg = <0xff8c0c00 0x400>;
+				parent = <&gmac0>;
+			};
+
+			emac1-rx-ecc at ff8c1000 {
+				compatible = "altr,socfpga-a10-emac1-rx-ecc";
+				reg = <0xff8c1000 0x400>;
+				parent = <&gmac1>;
+			};
+
+			emac1-tx-ecc at ff8c1400 {
+				compatible = "altr,socfpga-a10-emac1-tx-ecc";
+				reg = <0xff8c1400 0x400>;
+				parent = <&gmac1>;
+			};
+
+			emac2-rx-ecc at ff8c1800 {
+				compatible = "altr,socfpga-a10-emac2-rx-ecc";
+				reg = <0xff8c1800 0x400>;
+				parent = <&gmac2>;
+			};
+
+			emac2-tx-ecc at ff8c1c00 {
+				compatible = "altr,socfpga-a10-emac2-tx-ecc";
+				reg = <0xff8c1c00 0x400>;
+				parent = <&gmac2>;
+			};
 		};
 
 		rst: rstmgr at ffd05000 {
-- 
1.7.9.5
