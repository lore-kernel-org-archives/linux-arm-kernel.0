From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 14:40:29 +0200
Subject: [PATCH 4/5] ARM: realview: no need to select SMP_ON_UP explicitly
In-Reply-To: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
References: <1470832830-10274-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1470832830-10274-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

SMP_ON_UP is already defaulted to "y" and has all dependencies expressed
- no need to select it per platform level

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index a52b35aeca86..5f194c42bbdf 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -28,7 +28,6 @@ config REALVIEW_DT
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
-	select SMP_ON_UP if SMP
 	select SOC_REALVIEW
 	select USE_OF
 	select ZONE_DMA
-- 
2.7.4
