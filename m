From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:15 +0200
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-7-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
 arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index eed3df0..1a70277 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -223,6 +223,23 @@
 			};
 		};
 
+		dmac_s: dmac at f8003000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xf8003000 0x1000>;
+			status = "disabled";
+			interrupt-parent = <&intc>;
+			interrupts = <0 13 4>,
+			             <0 14 4>, <0 15 4>,
+			             <0 16 4>, <0 17 4>,
+			             <0 40 4>, <0 41 4>,
+			             <0 42 4>, <0 43 4>;
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <4>;
+			clocks = <&clkc 27>;
+			clock-names = "apb_pclk";
+		};
+
 		devcfg: devcfg at f8007000 {
 			compatible = "xlnx,zynq-devcfg-1.0";
 			reg = <0xf8007000 0x100>;
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 56f68ea..e60a0a9 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,6 +34,10 @@
 	};
 };
 
+&dmac_s {
+	status = "okay";
+};
+
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
-- 
1.9.3
