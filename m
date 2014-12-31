From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 31 Dec 2014 16:57:52 +0800
Subject: [PATCH 3/3] clk: berlin: bg2q: remove non-exist "smemc" gate clock
In-Reply-To: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
References: <1420016272-6789-1-git-send-email-jszhang@marvell.com>
Message-ID: <1420016272-6789-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "smemc" clock is removed on BG2Q SoCs. In fact, bit19 of clkenable
register is for nfc. Current code use bit19 for non-exist "smemc"
incorrectly, this prevents eMMC from working due to the sdhci's
"core" clk is still gated.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Cc: stable at vger.kernel.org # 3.16+
---
 drivers/clk/berlin/bg2q.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 21784e4..440ef81 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -285,7 +285,6 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 	{ "pbridge",	"perif",	15, CLK_IGNORE_UNUSED },
 	{ "sdio",	"perif",	16, CLK_IGNORE_UNUSED },
 	{ "nfc",	"perif",	18 },
-	{ "smemc",	"perif",	19 },
 	{ "pcie",	"perif",	22 },
 };
 
-- 
2.1.4
