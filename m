From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 24 Jan 2015 12:56:32 +0100
Subject: [PATCH 2/2] sunxi: clk: Set sun6i-pll1 n_start = 1
In-Reply-To: <1422100592-19981-1-git-send-email-hdegoede@redhat.com>
References: <1422100592-19981-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1422100592-19981-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For all pll-s on sun6i n == 0 means use a multiplier of 1, rather then 0 as
it means on sun4i / sun5i / sun7i. n_start = 1 is already correctly set
for sun6i pll6, but was missing for pll1, this commit fixes this.

Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 24c7cc1..699458e 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -584,6 +584,7 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
 	.kwidth = 2,
 	.mshift = 0,
 	.mwidth = 2,
+	.n_start = 1,
 };
 
 static struct clk_factors_config sun8i_a23_pll1_config = {
-- 
2.1.0
