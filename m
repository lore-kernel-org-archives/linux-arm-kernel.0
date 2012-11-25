From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Sun, 25 Nov 2012 21:17:05 +0100
Subject: [PATCH 4/4] apf27: add rtc ds1374 to the device tree
In-Reply-To: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
References: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <1353874625-14754-5-git-send-email-tremyfr@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 arch/arm/boot/dts/imx27-apf27.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
index c0327c0..20b8ef2 100644
--- a/arch/arm/boot/dts/imx27-apf27.dts
+++ b/arch/arm/boot/dts/imx27-apf27.dts
@@ -42,6 +42,16 @@
 			ethernet at 1002b000 {
 				status = "okay";
 			};
+
+			i2c1: i2c at 10012000 {
+				clock-frequency = <400000>;
+				status = "okay";
+
+				rtc at 68 {
+					compatible = "dallas,ds1374";
+					reg = <0x68>;
+				};
+			};
 		};
 
 		nand at d8000000 {
-- 
1.7.4.4
