From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 19 Sep 2012 13:57:41 +0200
Subject: [PATCH v2 2/2] ARM: at91: add at91sam9_wdt driver to at91sam9260
In-Reply-To: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on an at91sam9260 board (evk-pro3)

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 66389c1..680b1c8 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -233,6 +233,12 @@
 					trigger-external;
 				};
 			};
+
+			watchdog at fffffd40 {
+				compatible = "atmel,at91sam9-wdt";
+				reg = <0xfffffd40 0x10>;
+			};
+
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.11.3
