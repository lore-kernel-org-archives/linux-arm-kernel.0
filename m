From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Mar 2014 15:41:50 +0100
Subject: [PATCH v4 5/7] ARM: sun6i: Protect SDRAM gating bit
In-Reply-To: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1394462512-11620-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent the SDRAM controller from being gated by force-enabling it in the
machine code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sun6i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-sunxi/sun6i.c b/arch/arm/mach-sunxi/sun6i.c
index 6b3905505fe0..1ccb27524a9e 100644
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
