From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 30 Jul 2010 22:58:40 +0200
Subject: [PATCH] eukrea-baseboards: fix the merge in one file
Message-ID: <1280523520-17236-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last change I did made a big mess in function names and CONFIG names,
this patch fixes this so that the baseboard support is really built
when selected.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |    2 +-
 arch/arm/mach-mx25/mach-cpuimx25.c                 |    4 ++--
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |    2 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |    4 ++--
 arch/arm/plat-mxc/include/mach/eukrea-baseboards.h |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index 91931dc..4aaadc7 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -215,7 +215,7 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
  * Add platform devices present on this baseboard and init
  * them from CPU side as far as required to use them later on
  */
-void __init eukrea_mbimxsd_baseboard_init(void)
+void __init eukrea_mbimxsd25_baseboard_init(void)
 {
 	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
 			ARRAY_SIZE(eukrea_mbimxsd_pads)))
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 56b2e26..b5efee2 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -147,8 +147,8 @@ static void __init eukrea_cpuimx25_init(void)
 	if (!otg_mode_host)
 		mxc_register_device(&otg_udc_device, &otg_device_pdata);
 
-#ifdef CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD
-	eukrea_mbimxsd_baseboard_init();
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD25_BASEBOARD
+	eukrea_mbimxsd25_baseboard_init();
 #endif
 }
 
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 1dc5004..f8f15e3 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -216,7 +216,7 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata = {
  * Add platform devices present on this baseboard and init
  * them from CPU side as far as required to use them later on
  */
-void __init eukrea_mbimxsd_baseboard_init(void)
+void __init eukrea_mbimxsd35_baseboard_init(void)
 {
 	if (mxc_iomux_v3_setup_multiple_pads(eukrea_mbimxsd_pads,
 			ARRAY_SIZE(eukrea_mbimxsd_pads)))
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 63f970f..e4268bb 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -201,8 +201,8 @@ static void __init mxc_board_init(void)
 	if (!otg_mode_host)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 
-#ifdef CONFIG_MACH_EUKREA_MBIMXSD_BASEBOARD
-	eukrea_mbimxsd_baseboard_init();
+#ifdef CONFIG_MACH_EUKREA_MBIMXSD35_BASEBOARD
+	eukrea_mbimxsd35_baseboard_init();
 #endif
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
index 634e3f4..656acb4 100644
--- a/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
+++ b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
@@ -37,9 +37,9 @@
  * mach-mx5/eukrea_mbimx51-baseboard.c for cpuimx51
  */
 
-extern void eukrea_mbimx25_baseboard_init(void);
+extern void eukrea_mbimxsd25_baseboard_init(void);
 extern void eukrea_mbimx27_baseboard_init(void);
-extern void eukrea_mbimx35_baseboard_init(void);
+extern void eukrea_mbimxsd35_baseboard_init(void);
 extern void eukrea_mbimx51_baseboard_init(void);
 
 #endif
-- 
1.6.3.3
