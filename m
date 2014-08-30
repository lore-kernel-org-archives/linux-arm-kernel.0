From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Aug 2014 22:03:01 +0200
Subject: [PATCH v2 02/12] clk: Include of.h in clock-provider.h
In-Reply-To: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1409428991-2442-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_OF_DECLARE relies on OF_DECLARE_1 that is defined in of.h. Fixes build
errors when one use CLK_OF_DECLARE but doesn't include of.h

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/clk-provider.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 201a6195a3eb..69b20d4c1e1a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_COMMON_CLK
 
-- 
2.0.2
