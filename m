From: B56489@freescale.com (Yunhui Cui)
Date: Wed, 2 Mar 2016 13:52:15 +0800
Subject: [PATCH] dts/ls1043a-rdb: add the DTS for DSPI support
Message-ID: <1456897935-40507-1-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dts nodes for DSPI on LS1043A-RDB.

Signed-off-by: Yunhui Cui <B56489@freescale.com>
Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index ce23557..f895fc0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -107,6 +107,19 @@
 		};
 };
 
+&dspi0 {
+	bus-num = <0>;
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
+		reg = <0>;
+		spi-max-frequency = <1000000>; /* input clock */
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
-- 
2.1.0.27.g96db324
