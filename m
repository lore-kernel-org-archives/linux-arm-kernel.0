From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Wed, 28 Mar 2012 12:05:50 +0200
Subject: [PATCH v2 3/3] arm: at91: dt: sam9g25ek add mci support
In-Reply-To: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
References: <1332929150-14240-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1332929150-14240-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7a13d09..960de2b 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,22 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc at f0008000 {
+				status = "okay";
+				slot at 0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 15 0>;
+				};
+			};
+
+			mmc1: mmc at f000c000 {
+				status = "okay";
+				slot at 0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 14 0>;
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
-- 
1.7.5.4
