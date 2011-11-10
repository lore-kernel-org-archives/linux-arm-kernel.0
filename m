From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:10 +0800
Subject: [PATCH 5/9] ARM: mxc: arch_reset: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-5-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/system.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 9dad8dc..afbe038 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -53,8 +53,10 @@ void arch_reset(char mode, const char *cmd)
 		struct clk *clk;
 
 		clk = clk_get_sys("imx2-wdt.0", NULL);
-		if (!IS_ERR(clk))
+		if (!IS_ERR(clk)) {
+			clk_prepare(clk);
 			clk_enable(clk);
+		}
 		wcr_enable = (1 << 2);
 	}
 
-- 
1.7.5.4
