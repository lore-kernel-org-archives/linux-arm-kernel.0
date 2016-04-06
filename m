From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:50 +0900
Subject: [PATCH v2 11/11] ARM: dts: s5p: Fix DTC unit name warnings in SMDKv210
 board
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-11-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in SMDKv210 board:

Warning (unit_address_vs_reg): Node /soc/fimd at f8000000/display-timings/timing at 0 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Don't add unit name to memory.
2. Add Javier's tag.
---
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 54fcc3fc82e2..9eb6aff3e38f 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -197,7 +197,7 @@
 	display-timings {
 		native-mode = <&timing0>;
 
-		timing0: timing at 0 {
+		timing0: timing {
 			/* 800x480 at 60Hz */
 			clock-frequency = <24373920>;
 			hactive = <800>;
-- 
2.5.0
