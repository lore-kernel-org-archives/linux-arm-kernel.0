From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 15 Nov 2011 14:48:04 +0800
Subject: [PATCH V4 09/14] ARM: mx31moboard: add clk_prepare/clk_unprepare
In-Reply-To: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
References: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321339689-25256-10-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's for migrating to generic clk framework API.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 07034f4..d1a9337 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -505,7 +505,7 @@ static void mx31moboard_poweroff(void)
 	struct clk *clk = clk_get_sys("imx2-wdt.0", NULL);
 
 	if (!IS_ERR(clk))
-		clk_enable(clk);
+		clk_prepare_enable(clk);
 
 	mxc_iomux_mode(MX31_PIN_WATCHDOG_RST__WATCHDOG_RST);
 
-- 
1.7.5.4
