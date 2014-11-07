From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  7 Nov 2014 11:57:55 +0000
Subject: [PATCH 13/13] ARM: STi: DT: STih407: Add clk_ignore_unused to kernel
 bootargs
In-Reply-To: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415361475-6218-14-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we don't take a reference on some core interconnect
clocks which means when CCF turns off unused clocks the SoC will
hang. As a temp soltuion we will boot with clk_ignore_unused
parameter for all b2120 boards.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 862bb2f..7280b6d 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -8,7 +8,7 @@
  */
 / {
 	chosen {
-		bootargs = "console=ttyAS0,115200";
+		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
-- 
1.9.1
