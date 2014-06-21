From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 22 Jun 2014 00:09:48 +0200
Subject: [PATCH 3/3] ARM: add CLKSRC_OF dependency for PXA
In-Reply-To: <1403388588-11956-1-git-send-email-robert.jarzmik@free.fr>
References: <1403388588-11956-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1403388588-11956-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CLKSRC_OF for PXA architectures, as the clocksource
driver can be also initialized from device-tree.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c541..c300b68 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -646,6 +646,7 @@ config ARCH_PXA
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select CLKSRC_OF if OF
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
 	select HAVE_IDE
-- 
2.0.0.rc2
