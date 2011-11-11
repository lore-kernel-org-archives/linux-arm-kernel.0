From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 09:10:21 +0800
Subject: [PATCH V2 06/14] ARM: mxc: arch_reset: add clk_prepare/clk_unprepare
In-Reply-To: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
References: <1320973829-4388-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320973829-4388-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/system.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 9dad8dc..a667adc 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -54,7 +54,7 @@ void arch_reset(char mode, const char *cmd)
 
 		clk = clk_get_sys("imx2-wdt.0", NULL);
 		if (!IS_ERR(clk))
-			clk_enable(clk);
+			clk_prepare_enable(clk);
 		wcr_enable = (1 << 2);
 	}
 
-- 
1.7.5.4
