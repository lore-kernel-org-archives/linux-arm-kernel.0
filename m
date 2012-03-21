From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 21 Mar 2012 19:03:13 +0100
Subject: [PATCH 3/4] arm: at91: dt: sam9x5 add mci support
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1332352994-20983-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c111001..5846f99 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -191,6 +191,20 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			mmc0: mmc at f0008000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf0008000 0x600>;
+				interrupts = <12 4>;
+				status = "disabled";
+			};
+
+			mmc1: mmc at f000c000 {
+				compatible = "atmel,hsmci";
+				reg = <0xf000c000 0x600>;
+				interrupts = <26 4>;
+				status = "disabled";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.5.4
