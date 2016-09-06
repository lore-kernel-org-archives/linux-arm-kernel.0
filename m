From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:08 -0300
Subject: [PATCH 2/9] ARM: dts: imx1: Fix memory node build warnings with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

While at it, also pass the 'device_type' property as recommended by the
ePAPR specification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx1-ads.dts     | 3 ++-
 arch/arm/boot/dts/imx1-apf9328.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index f504986..3044b76 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -20,7 +20,8 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 8000000 {
+		device_type = "memory";
 		reg = <0x08000000 0x04000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index e8b4b52c..ee4b1b1 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -20,7 +20,8 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
+	memory at 8000000 {
+		device_type = "memory";
 		reg = <0x08000000 0x00800000>;
 	};
 };
-- 
1.9.1
