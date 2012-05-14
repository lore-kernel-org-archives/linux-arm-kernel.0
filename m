From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 14 May 2012 15:12:42 +0100
Subject: [PATCH] clk: Constify struct clk_init_data
Message-ID: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow drivers to declare their clk_init_data const, the framework really
shouldn't be modifying the data.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/clk-provider.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c1c23b9..fc43ea6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -143,7 +143,7 @@ struct clk_init_data {
  */
 struct clk_hw {
 	struct clk *clk;
-	struct clk_init_data *init;
+	const struct clk_init_data *init;
 };
 
 /*
-- 
1.7.10
