From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Aug 2013 17:50:09 -0500
Subject: [PATCH 5/5] ARM: highbank: select required errata work-arounds
In-Reply-To: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375743009-28972-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Ensure necessary errata work-arounds are always enabled for Highbank
and Midway platforms. Highbank requires 764369 and 764369. Midway requires
798181, but only the first half of the work-around (no IPI). Support for
skipping the IPI is introduced in another commit.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 8b2948f..386835e 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -5,6 +5,9 @@ config ARCH_HIGHBANK
 	select ARCH_HAS_OPP
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
+	select ARM_ERRATA_764369
+	select ARM_ERRATA_775420
+	select ARM_ERRATA_798181
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select CACHE_L2X0
-- 
1.8.1.2
