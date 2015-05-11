From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 May 2015 15:12:49 +0100
Subject: [PATCH] ARM: STi: DT: STih407: Re-order #include <*.dtsi> files
Message-ID: <1431353569-13291-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a regression where serial is enabled by the first
(board) DTSI, then disabled by the second (SoC) file.  To enable
serial and keep it enabled, we need to include the file which enables
it last.

Reported-by: LAVA [via Peter Griffin <peter.griffin@linaro.org>]
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-b2120.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index af48714..6d93475 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -7,8 +7,8 @@
  * published by the Free Software Foundation.
  */
 /dts-v1/;
-#include "stihxxx-b2120.dtsi"
 #include "stih407.dtsi"
+#include "stihxxx-b2120.dtsi"
 / {
 	model = "STiH407 B2120";
 	compatible = "st,stih407-b2120", "st,stih407";
-- 
1.9.1
