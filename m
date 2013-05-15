From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 15 May 2013 09:36:41 -0300
Subject: [PATCH] ARM: ux500: select REGULATOR
Message-ID: <1368621401-18569-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_MOP500 selects REGULATOR_FIXED_VOLTAGE but not REGULATOR. This
patch makes it select the latter too.

Seen as:
    warning: (MACH_DOVE_DT && ARCH_KIRKWOOD_DT && MACH_AMS_DELTA &&
    MACH_MOP500 && TPS6105X) selects REGULATOR_FIXED_VOLTAGE which has
    unmet direct dependencies (REGULATOR)

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/mach-ux500/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 6a4387e..b19b072 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -51,6 +51,7 @@ config MACH_MOP500
 	bool "U8500 Development platform, MOP500 versions"
 	select I2C
 	select I2C_NOMADIK
+	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	select SOC_BUS
 	select UX500_SOC_DB8500
-- 
1.8.2.3
