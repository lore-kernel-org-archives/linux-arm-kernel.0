From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu,  6 Jun 2013 16:31:27 +0530
Subject: [PATCH 13/13] ARM: Exynos: extend soft-reset support for Exynos5420
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1370516488-25860-13-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the soft reset support for Exynos5420 SoC.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/mach-exynos/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index fbe1aa7..dc7c134 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -321,7 +321,8 @@ void exynos5_restart(char mode, const char *cmd)
 	u32 val;
 	void __iomem *addr;
 
-	if (of_machine_is_compatible("samsung,exynos5250")) {
+	if (of_machine_is_compatible("samsung,exynos5250") ||
+		(of_machine_is_compatible("samsung,exynos5420"))) {
 		val = 0x1;
 		addr = EXYNOS_SWRESET;
 	} else if (of_machine_is_compatible("samsung,exynos5440")) {
-- 
1.7.9.5
