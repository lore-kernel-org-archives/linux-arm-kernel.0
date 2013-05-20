From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 May 2013 18:26:00 +0200
Subject: [PATCH 7/7] ARM: at91: sam9m10g45ek add udc DT support
In-Reply-To: <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1369067160-3230-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 89c50d1..17665ef 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -112,6 +112,11 @@
 					reg = <0>;
 				};
 			};
+
+			usb2: gadget at fff78000 {
+				atmel,vbus-gpio = <&pioB 19 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.10.4
