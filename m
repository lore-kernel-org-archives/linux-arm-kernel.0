From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Sat, 25 Feb 2012 12:55:07 -0700
Subject: [PATCH 6/6] ARM: ux500: select I2C for U8500
In-Reply-To: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1330199707-5179-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1330199707-5179-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The U8500 platform selects the TPS6105X, so also select the I2C
layer that this driver depends on.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c7d1fb5..f0f6199 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -29,6 +29,7 @@ config MACH_U8500
 	select UX500_SOC_DB8500
 	select TPS6105X
 	select SOC_BUS
+	select I2C
 	help
 	  Include support for the mop500 development platform.
 
-- 
1.7.5.4
