From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 23 Mar 2013 16:06:51 +0100
Subject: [PATCH] ARM: dove: fix Dove cpu type from V7 to PJ4
Message-ID: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU used in Marvell Dove SoCs is a PJ4 Sheeva core. Using
CONFIG_CPU_PJ4 instead of CONFIG_CPU_V7 will also allow to enable
iWMMXt extensions on Dove.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c3bdce..4fc9bca 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -556,7 +556,7 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select ARCH_REQUIRE_GPIOLIB
-	select CPU_V7
+	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select PINCTRL
-- 
1.7.10.4
