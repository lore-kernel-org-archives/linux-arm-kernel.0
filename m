From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:37 -0400
Subject: [PATCH 05/10] ARM: mach-ixp4xx: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ixp4xx/avila-setup.c         |    6 ++++++
 arch/arm/mach-ixp4xx/coyote-setup.c        |    3 +++
 arch/arm/mach-ixp4xx/dsmg600-setup.c       |    3 +++
 arch/arm/mach-ixp4xx/fsg-setup.c           |    3 +++
 arch/arm/mach-ixp4xx/gateway7001-setup.c   |    3 +++
 arch/arm/mach-ixp4xx/goramo_mlr.c          |    3 +++
 arch/arm/mach-ixp4xx/gtwx5715-setup.c      |    3 +++
 arch/arm/mach-ixp4xx/include/mach/memory.h |    4 ----
 arch/arm/mach-ixp4xx/ixdp425-setup.c       |   12 ++++++++++++
 arch/arm/mach-ixp4xx/nas100d-setup.c       |    3 +++
 arch/arm/mach-ixp4xx/nslu2-setup.c         |    3 +++
 arch/arm/mach-ixp4xx/vulcan-setup.c        |    3 +++
 arch/arm/mach-ixp4xx/wg302v2-setup.c       |    3 +++
 13 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index 73745ff..05bf40d 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -169,6 +169,9 @@ MACHINE_START(AVILA, "Gateworks Avila Network Platform")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= avila_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 
  /*
@@ -184,6 +187,9 @@ MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= avila_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
 
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index 355e3de..0adf01b 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -114,6 +114,9 @@ MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= coyote_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index d398229..3eb8861 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -284,4 +284,7 @@ MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &dsmg600_timer,
 	.init_machine	= dsmg600_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 727ee39..d26bd4b 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -275,5 +275,8 @@ MACHINE_START(FSG, "Freecom FSG-3")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= fsg_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 9dc0b4e..85e179e 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -101,5 +101,8 @@ MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= gateway7001_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 3e8c0e3..34955e8 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -501,4 +501,7 @@ MACHINE_START(GORAMO_MLR, "MultiLink")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= gmlr_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index 77abead..283e128 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -169,6 +169,9 @@ MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= gtwx5715_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
index 34e7940..4caf176 100644
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
@@ -14,8 +14,4 @@
  */
 #define PLAT_PHYS_OFFSET	UL(0x00000000)
 
-#ifdef CONFIG_PCI
-#define ARM_DMA_ZONE_SIZE	SZ_64M
-#endif
-
 #endif
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index dca4f7f..d89e11f 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -258,6 +258,9 @@ MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= ixdp425_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
 
@@ -269,6 +272,9 @@ MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= ixdp425_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
 
@@ -280,6 +286,9 @@ MACHINE_START(IXCDP1100, "Intel IXCDP1100 Development Platform")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= ixdp425_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
 
@@ -291,5 +300,8 @@ MACHINE_START(KIXRP435, "Intel KIXRP435 Reference Platform")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= ixdp425_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index f18fee7..5cb107b 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -319,4 +319,7 @@ MACHINE_START(NAS100D, "Iomega NAS 100d")
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
 	.init_machine	= nas100d_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index f79b62e..446375d 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -305,4 +305,7 @@ MACHINE_START(NSLU2, "Linksys NSLU2")
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &nslu2_timer,
 	.init_machine	= nslu2_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
index 4e72cfd..4a2d4e7 100644
--- a/arch/arm/mach-ixp4xx/vulcan-setup.c
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -241,4 +241,7 @@ MACHINE_START(ARCOM_VULCAN, "Arcom/Eurotech Vulcan")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= vulcan_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 5d148c7..5397237 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -102,5 +102,8 @@ MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
 	.init_machine	= wg302v2_init,
+#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
+	.dma_zone_size	= SZ_64M,
+#endif
 MACHINE_END
 #endif
-- 
1.7.4
