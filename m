From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:53 +0200
Subject: [PATCH 21/26] ARM: pxa: select POWER_SUPPLY on raumfeld
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-22-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The raumfeld platform code calls power_supply_set_battery_charged
which is part of the power supply layer, so that always has
to be enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index cd94f2f..491c522 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -453,15 +453,18 @@ config MACH_RAUMFELD_RC
 	bool "Raumfeld Controller"
 	select PXA3xx
 	select CPU_PXA300
+	select POWER_SUPPLY
 	select HAVE_PWM
 
 config MACH_RAUMFELD_CONNECTOR
 	bool "Raumfeld Connector"
+	select POWER_SUPPLY
 	select PXA3xx
 	select CPU_PXA300
 
 config MACH_RAUMFELD_SPEAKER
 	bool "Raumfeld Speaker"
+	select POWER_SUPPLY
 	select PXA3xx
 	select CPU_PXA300
 
-- 
1.7.5.4
