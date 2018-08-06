From: colin.king@canonical.com (Colin King)
Date: Mon,  6 Aug 2018 14:44:02 +0100
Subject: [PATCH] clk: mediatek: remove unused array audio_parents
Message-ID: <20180806134402.1055-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Array audio_parents is declared but never used, hence it is redundant
and can be removed.

Cleans up clang warning:
warning: 'audio_parents' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/mediatek/clk-mt2701.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 4dda8988b2f0..ab6ab07f53e6 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -249,11 +249,6 @@ static const char * const msdc30_parents[] = {
 	"univpll2_d4"
 };
 
-static const char * const audio_parents[] = {
-	"clk26m",
-	"syspll1_d16"
-};
-
 static const char * const aud_intbus_parents[] = {
 	"clk26m",
 	"syspll1_d4",
-- 
2.17.1
