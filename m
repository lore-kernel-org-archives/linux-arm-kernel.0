From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 26 Aug 2016 15:46:21 -0500
Subject: [PATCH 2/2] arm64: dts: add stdout-path to chosen node for
 ls2080a/ls1043a boards
In-Reply-To: <1472244381-1766-1-git-send-email-stuart.yoder@nxp.com>
References: <1472244381-1766-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <1472244381-1766-3-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a default stdout-path to chosen node for ls2080a/ls1043a boards to
allow booting kernels without specifying console info in bootargs.

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index f813d67..dd9e919 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -61,6 +61,10 @@
 		serial2 = &duart2;
 		serial3 = &duart3;
 	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &duart0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 8031cde..d2313e0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -57,6 +57,10 @@
 		serial2 = &duart2;
 		serial3 = &duart3;
 	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &i2c0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
index e8801fa..b0dd010 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
@@ -57,6 +57,9 @@
 		serial1 = &serial1;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &esdhc {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index e127f0b..ad0ebb8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -56,6 +56,10 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
 };
 
 &esdhc {
-- 
1.9.0
