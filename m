From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:20 +0200
Subject: [PATCH 2/9] drivers: clk: st: Incorrect register offset used for
 lock_status
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-3-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Incorrect register offset used for sthi407 clockgenC

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
---
 drivers/clk/st/clkgen-fsyn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index e94197f..e6d7073 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -340,7 +340,7 @@ static const struct clkgen_quadfs_data st_fs660c32_C_407 = {
 		    CLKGEN_FIELD(0x30c, 0xf, 20),
 		    CLKGEN_FIELD(0x310, 0xf, 20) },
 	.lockstatus_present = true,
-	.lock_status = CLKGEN_FIELD(0x2A0, 0x1, 24),
+	.lock_status = CLKGEN_FIELD(0x2f0, 0x1, 24),
 	.powerup_polarity = 1,
 	.standby_polarity = 1,
 	.pll_ops	= &st_quadfs_pll_c32_ops,
-- 
1.9.1
