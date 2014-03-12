From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Mar 2014 12:41:41 -0300
Subject: [PATCH 1/1] clk: mvebu: Fix ratio register offset on A375 SoC
In-Reply-To: <1394638901-13368-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394638901-13368-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1394638901-13368-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the ratio register offset which is 0x4,
as per the Armada 375 SoC specification.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/clk-corediv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 4da6076..4af33ba 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -213,7 +213,7 @@ static const struct clk_corediv_soc_desc armada375_corediv_soc = {
 		.set_rate = clk_corediv_set_rate,
 	},
 	.ratio_reload = BIT(8),
-	.ratio_offset = 0x8,
+	.ratio_offset = 0x4,
 };
 
 static void __init
-- 
1.9.0
