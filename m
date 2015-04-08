From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:16 +0200
Subject: [PATCH 5/8] clk: cdce706: Constify parent names in clock init data
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The array of parent names can be made as array of const pointers to
const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/clk-cdce706.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index b8e4f8a822e9..8a2dfd0012f3 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -94,7 +94,7 @@ static const char * const cdce706_source_name[] = {
 	"clk_in0", "clk_in1",
 };
 
-static const char *cdce706_clkin_name[] = {
+static const char * const cdce706_clkin_name[] = {
 	"clk_in",
 };
 
@@ -102,7 +102,7 @@ static const char * const cdce706_pll_name[] = {
 	"pll1", "pll2", "pll3",
 };
 
-static const char *cdce706_divider_parent_name[] = {
+static const char * const cdce706_divider_parent_name[] = {
 	"clk_in", "pll1", "pll2", "pll2", "pll3",
 };
 
-- 
1.9.1
