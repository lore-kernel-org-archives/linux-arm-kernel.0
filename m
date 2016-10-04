From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  4 Oct 2016 11:46:15 +0200
Subject: [PATCH 02/14] clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to ac-dig
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <8dfe0935d35b8a218ebf39d37113e27289a0de9b.1475571575.git.mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the flag CLK_SET_RATE_PARENT to 'ac-dig' clock.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 96b40ca..37c4d8d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -440,7 +440,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 			     0x13c, 16, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
-		      0x140, BIT(31), 0);
+		      0x140, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(ac_dig_4x_clk,	"ac-dig-4x",	"pll-audio-4x",
 		      0x140, BIT(30), 0);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
-- 
2.9.3
