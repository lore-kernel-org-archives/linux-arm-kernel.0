From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:12:57 +0200
Subject: [PATCH 4/8] ARM: ux500: Enable Kconfig for the generic PM domain
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ux500 uses the generic PM domain, let's enable the corresponding
Kconfig as long as CONFIG_PM also is enabled.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 699e860..c9ac19b 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -32,6 +32,7 @@ config UX500_SOC_DB8500
 	select PINCTRL_AB8540
 	select REGULATOR
 	select REGULATOR_DB8500_PRCMU
+	select PM_GENERIC_DOMAINS if PM
 
 config MACH_MOP500
 	bool "U8500 Development platform, MOP500 versions"
-- 
1.9.1
