From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 09:10:24 +0800
Subject: [PATCH V2 09/14] ARM: mx31moboard: add clk_prepare/clk_unprepare
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320973829-4388-10-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
