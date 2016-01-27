From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Jan 2016 11:06:49 +0100
Subject: [PATCH 2/2] ARM: dts: at91: sama5d4 xplained: fix phy0 IRQ type
In-Reply-To: <1453889209-13742-1-git-send-email-nicolas.ferre@atmel.com>
References: <1453889209-13742-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1453889209-13742-2-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For phy0 KSZ8081, the type of GPIO IRQ should be "level low" instead of
"edge falling".

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Fixes: 38153a017896 ("ARM: at91/dt: sama5d4: add dts for sama5d4 xplained board")
Cc: <stable@vger.kernel.org> # 4.1+
---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index 8cf9999cb0cd..569026e8f96c 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -91,7 +91,7 @@
 
 				phy0: ethernet-phy at 1 {
 					interrupt-parent = <&pioE>;
-					interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+					interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 					reg = <1>;
 				};
 			};
-- 
2.1.3
