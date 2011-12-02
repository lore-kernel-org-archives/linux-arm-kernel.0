From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  2 Dec 2011 18:50:37 +0100
Subject: [PATCH] ARM: at91/net: add macb ethernet controller in 9g45 DT
In-Reply-To: <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
References: <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1322848237-23154-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Cadence macb ethernet controller in at91sam9g45 .dtsi and
enable it in at91sam9m10g45ek board device tree file.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi     |    7 +++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index e89b1d7..67f94d3 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -101,6 +101,13 @@
 				atmel,use-dma-tx;
 				status = "disabled";
 			};
+
+			macb0: ethernet at fffbc000 {
+				compatible = "cdns,at32ap7000-macb", "cdns,macb";
+				reg = <0xfffbc000 0x100>;
+				interrupts = <25 4>;
+				status = "disabled";
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 85b34f5..17377a2 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -30,6 +30,12 @@
 			usart1: serial at fff90000 {
 				status = "okay";
 			};
+
+			macb0: ethernet at fffbc000 {
+				local-mac-address = [3a 0e 03 04 05 06];
+				phy-mode = "rmii";
+				status = "okay";
+			};
 		};
 	};
 };
-- 
1.7.5.4
