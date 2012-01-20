From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:22:55 +0000
Subject: [PATCH 17/19] PCMCIA: Add Kconfig control for building sa11xx_base.c
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBcV-0005iY-ME@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa11xx_base.c is currently built when either PCMCIA_SA1100 or
PCMCIA_SA1111 are selected.  Let's move the logic into Kconfig.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/Kconfig  |    5 +++++
 drivers/pcmcia/Makefile |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index f9e3fb3..b7f3d29 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -183,10 +183,14 @@ config PCMCIA_BCM63XX
 config PCMCIA_SOC_COMMON
 	tristate
 
+config PCMCIA_SA11XX_BASE
+	tristate
+
 config PCMCIA_SA1100
 	tristate "SA1100 support"
 	depends on ARM && ARCH_SA1100 && PCMCIA
 	select PCMCIA_SOC_COMMON
+	select PCMCIA_SA11XX_BASE
 	help
 	  Say Y here to include support for SA11x0-based PCMCIA or CF
 	  sockets, found on HP iPAQs, Yopy, and other StrongARM(R)/
@@ -198,6 +202,7 @@ config PCMCIA_SA1111
 	tristate "SA1111 support"
 	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA
 	select PCMCIA_SOC_COMMON
+	select PCMCIA_SA11XX_BASE
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index ec543a4..05136dd 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -25,8 +25,9 @@ obj-$(CONFIG_I82092)				+= i82092.o
 obj-$(CONFIG_TCIC)				+= tcic.o
 obj-$(CONFIG_PCMCIA_M8XX)			+= m8xx_pcmcia.o
 obj-$(CONFIG_PCMCIA_SOC_COMMON)			+= soc_common.o
-obj-$(CONFIG_PCMCIA_SA1100)			+= sa11xx_base.o sa1100_cs.o
-obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_base.o sa1111_cs.o
+obj-$(CONFIG_PCMCIA_SA11XX_BASE)		+= sa11xx_base.o
+obj-$(CONFIG_PCMCIA_SA1100)			+= sa1100_cs.o
+obj-$(CONFIG_PCMCIA_SA1111)			+= sa1111_cs.o
 obj-$(CONFIG_M32R_PCC)				+= m32r_pcc.o
 obj-$(CONFIG_M32R_CFC)				+= m32r_cfc.o
 obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
-- 
1.7.4.4
