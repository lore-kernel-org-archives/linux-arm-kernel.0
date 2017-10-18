From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 18 Oct 2017 07:22:08 -0400
Subject: [PATCH 3/3] arm64: dts: hisilicon: supplement properties of emmc
 nodes for hi3798cv200-poplar board
In-Reply-To: <1508325728-55823-1-git-send-email-xuejiancheng@hisilicon.com>
References: <1508325728-55823-1-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <1508325728-55823-4-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: tianshuliang <tianshuliang@hisilicon.com>

Supplement properties of emmc nodes to support high performance.

Signed-off-by: tianshuliang <tianshuliang@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 12 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi       |  8 +++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index 6a0b7e9..b890829 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -160,4 +160,16 @@
 	status = "okay";
 	label = "LS-UART0";
 };
+
+&emmc {
+	status = "okay";
+	num-slots = <1>;
+	fifo-depth = <256>;
+	clock-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	bus-width = <8>;
+};
 /* No optional LS-UART1 on Low Speed Expansion Connector. */
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 5a73c68..df62382 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -241,12 +241,14 @@
 		};
 
 		emmc: mmc at 9830000 {
-			compatible = "snps,dw-mshc";
+			compatible = "hisilicon,hi3798cv200-dw-mshc";
 			reg = <0x9830000 0x10000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HISTB_MMC_CIU_CLK>,
-				 <&crg HISTB_MMC_BIU_CLK>;
-			clock-names = "ciu", "biu";
+				 <&crg HISTB_MMC_BIU_CLK>,
+				 <&crg HISTB_MMC_SAMPLE_CLK>,
+				 <&crg HISTB_MMC_DRV_CLK>;
+			clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
 		};
 
 		gpio0: gpio at 8b20000 {
-- 
2.7.4
