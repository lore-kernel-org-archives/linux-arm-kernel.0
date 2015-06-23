From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:25 +0200
Subject: [PATCH 7/9] drivers: clk: st: Fix mux bit-setting for Cortex A9 clocks
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the mux bit-setting for ClockgenA9.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 3919a67..ecb492e 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -586,7 +586,7 @@ static struct clkgen_mux_data stih416_a9_mux_data = {
 };
 static struct clkgen_mux_data stih407_a9_mux_data = {
 	.offset = 0x1a4,
-	.shift = 1,
+	.shift = 0,
 	.width = 2,
 };
 
-- 
1.9.1
