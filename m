From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 16:48:07 +0100
Subject: [PATCH 1/4] ARM: ux500: Rid ignored return value of
 regulator_enable() compiler warning
In-Reply-To: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367509690-24022-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-ux500/board-mop500.c: In function ?mop500_prox_activate?:
arch/arm/mach-ux500/board-mop500.c:406:18: warning: ignoring return value of
        ?regulator_enable?, declared with attribute warn_unused_result
        [-Wunused-result]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a15dd6b..9bc762a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -403,8 +403,8 @@ static int mop500_prox_activate(struct device *dev)
 			"no regulator\n");
 		return PTR_ERR(prox_regulator);
 	}
-	regulator_enable(prox_regulator);
-	return 0;
+	
+	return regulator_enable(prox_regulator);
 }
 
 static void mop500_prox_deactivate(struct device *dev)
-- 
1.7.10.4
