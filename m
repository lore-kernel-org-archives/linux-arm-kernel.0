From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Mon, 29 Aug 2016 13:31:12 -0500
Subject: [PATCH 1/2 v2] arm64: dts: updates serial aliases for ls1043a rdb and
 qds boards
In-Reply-To: <1472495473-27387-1-git-send-email-stuart.yoder@nxp.com>
References: <1472495473-27387-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <1472495473-27387-2-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-add missing serial aliases to ls1043a-rdb
-update ls1043a-qds boards serial aliases to use the standard duarts
 instead of low power uarts

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
-v2
  -fix typo in commit message

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 10 ++++------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |  4 ++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 9d3e9fe..f813d67 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -56,12 +56,10 @@
 		gpio1 = &gpio2;
 		gpio2 = &gpio3;
 		gpio3 = &gpio4;
-		serial0 = &lpuart0;
-		serial1 = &lpuart1;
-		serial2 = &lpuart2;
-		serial3 = &lpuart3;
-		serial4 = &lpuart4;
-		serial5 = &lpuart5;
+		serial0 = &duart0;
+		serial1 = &duart1;
+		serial2 = &duart2;
+		serial3 = &duart3;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 4084631..8031cde 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -52,6 +52,10 @@
 
 	aliases {
 		crypto = &crypto;
+		serial0 = &duart0;
+		serial1 = &duart1;
+		serial2 = &duart2;
+		serial3 = &duart3;
 	};
 };
 
-- 
1.9.0
