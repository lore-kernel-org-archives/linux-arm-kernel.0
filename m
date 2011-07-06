From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:04 -0400
Subject: [PATCH 19/52] ARM: mach-ixp4xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-19-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp4xx/avila-setup.c       |    4 ++--
 arch/arm/mach-ixp4xx/coyote-setup.c      |    4 ++--
 arch/arm/mach-ixp4xx/dsmg600-setup.c     |    2 +-
 arch/arm/mach-ixp4xx/fsg-setup.c         |    2 +-
 arch/arm/mach-ixp4xx/gateway7001-setup.c |    2 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c        |    2 +-
 arch/arm/mach-ixp4xx/gtwx5715-setup.c    |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c     |    8 ++++----
 arch/arm/mach-ixp4xx/nas100d-setup.c     |    2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c       |    2 +-
 arch/arm/mach-ixp4xx/vulcan-setup.c      |    2 +-
 arch/arm/mach-ixp4xx/wg302v2-setup.c     |    2 +-
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 05bf40d..8133f24 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -167,7 +167,7 @@ MACHINE_START(AVILA, "Gateworks Avila Network Platform")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= avila_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
@@ -185,7 +185,7 @@ MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= avila_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index 0adf01b..b1d9ef0 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -112,7 +112,7 @@ MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= coyote_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
@@ -130,7 +130,7 @@ MACHINE_START(IXDPG425, "Intel IXDPG425")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= coyote_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 3eb8861..d927e11 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -279,7 +279,7 @@ static void __init dsmg600_init(void)
 
 MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
 	/* Maintainer: www.nslu2-linux.org */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &dsmg600_timer,
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index d26bd4b..65544d3 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -273,7 +273,7 @@ MACHINE_START(FSG, "Freecom FSG-3")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= fsg_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 85e179e..27849d4 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -99,7 +99,7 @@ MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= gateway7001_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 34955e8..5a85b0f 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -499,7 +499,7 @@ MACHINE_START(GORAMO_MLR, "MultiLink")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= gmlr_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index 283e128..92dfa7e 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -167,7 +167,7 @@ MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= gtwx5715_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index d89e11f..5454b66 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -256,7 +256,7 @@ MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= ixdp425_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
@@ -270,7 +270,7 @@ MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= ixdp425_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
@@ -284,7 +284,7 @@ MACHINE_START(IXCDP1100, "Intel IXCDP1100 Development Platform")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= ixdp425_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
@@ -298,7 +298,7 @@ MACHINE_START(KIXRP435, "Intel KIXRP435 Reference Platform")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= ixdp425_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 5cb107b..be70a49 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -314,7 +314,7 @@ static void __init nas100d_init(void)
 
 MACHINE_START(NAS100D, "Iomega NAS 100d")
 	/* Maintainer: www.nslu2-linux.org */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index 446375d..12a5949 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -300,7 +300,7 @@ static void __init nslu2_init(void)
 
 MACHINE_START(NSLU2, "Linksys NSLU2")
 	/* Maintainer: www.nslu2-linux.org */
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &nslu2_timer,
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
index 4a2d4e7..b9aa133 100644
--- a/arch/arm/mach-ixp4xx/vulcan-setup.c
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -239,7 +239,7 @@ MACHINE_START(ARCOM_VULCAN, "Arcom/Eurotech Vulcan")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= vulcan_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 5397237..fcd04f8 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -100,7 +100,7 @@ MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
-	.boot_params	= 0x0100,
+	.atag_offset	= 0x100,
 	.init_machine	= wg302v2_init,
 #if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
 	.dma_zone_size	= SZ_64M,
-- 
1.7.4
