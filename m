From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  4 Mar 2014 17:18:02 +0100
Subject: [PATCH v3 5/7] ARM: sun6i: Protect SDRAM gating bit
In-Reply-To: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393949884-892-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393949884-892-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent the SDRAM controller from being gated by force-enabling it in the
machine code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sun6i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-sunxi/sun6i.c b/arch/arm/mach-sunxi/sun6i.c
index 6b39055..1ccb275 100644
--- a/arch/arm/mach-sunxi/sun6i.c
+++ b/arch/arm/mach-sunxi/sun6i.c
@@ -34,6 +34,11 @@ static void __init sun6i_dt_init(void)
 	clk = clk_get(NULL, "cpu");
 	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
+
+	/* DDR gating clock */
+	clk = clk_get(NULL, "ahb1_sdram");
+	if (!IS_ERR(clk))
+		clk_prepare_enable(clk);
 }
 
 extern void __init sun6i_reset_init(void);
-- 
1.9.0
