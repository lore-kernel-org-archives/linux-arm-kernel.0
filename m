From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Sep 2011 21:55:42 +0900
Subject: [PATCH 3/3] ARM: SAMSUNG: Move S5P header files to plat-samsung
Message-ID: <019601cc7f70$431e36a0$c95aa3e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves header files from plat-s5p to plat-samsung to
remove plat-s5p directory to make one plat-samsung directory
for Samsung SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../include/plat/camport.h                         |    6 +++---
 .../{plat-s5p => plat-samsung}/include/plat/ehci.h |    6 +++---
 .../{plat-s5p => plat-samsung}/include/plat/irqs.h |    8 ++++----
 .../{plat-s5p => plat-samsung}/include/plat/mfc.h  |    6 +++---
 .../include/plat/mipi_csis.h                       |    6 +++---
 .../include/plat/regs-srom.h                       |    8 ++++----
 .../include/plat/reset.h                           |    8 ++++----
 .../include/plat/s5p-clock.h                       |    2 +-
 .../include/plat/s5p-time.h                        |    2 +-
 .../include/plat/sysmmu.h                          |    6 +++---
 .../include/plat/system-reset.h                    |    2 +-
 .../include/plat/usb-phy.h                         |    6 +++---
 12 files changed, 33 insertions(+), 33 deletions(-)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/camport.h (87%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/ehci.h (86%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/irqs.h (96%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/mfc.h (91%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/mipi_csis.h (91%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/regs-srom.h (89%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/reset.h (67%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p-clock.h (96%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p-time.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/sysmmu.h (96%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/system-reset.h (92%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/usb-phy.h (85%)

diff --git a/arch/arm/plat-s5p/include/plat/camport.h b/arch/arm/plat-samsung/include/plat/camport.h
similarity index 87%
rename from arch/arm/plat-s5p/include/plat/camport.h
rename to arch/arm/plat-samsung/include/plat/camport.h
index 71688c8..9db617d 100644
--- a/arch/arm/plat-s5p/include/plat/camport.h
+++ b/arch/arm/plat-samsung/include/plat/camport.h
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef PLAT_S5P_CAMPORT_H_
-#define PLAT_S5P_CAMPORT_H_ __FILE__
+#ifndef __PLAT_SAMSUNG_CAMPORT_H_
+#define __PLAT_SAMSUNG_CAMPORT_H_ __FILE__
 
 enum s5p_camport_id {
 	S5P_CAMPORT_A,
@@ -25,4 +25,4 @@ enum s5p_camport_id {
 int s5pv210_fimc_setup_gpio(enum s5p_camport_id id);
 int exynos4_fimc_setup_gpio(enum s5p_camport_id id);
 
-#endif
+#endif /* __PLAT_SAMSUNG_CAMPORT_H */
diff --git a/arch/arm/plat-s5p/include/plat/ehci.h b/arch/arm/plat-samsung/include/plat/ehci.h
similarity index 86%
rename from arch/arm/plat-s5p/include/plat/ehci.h
rename to arch/arm/plat-samsung/include/plat/ehci.h
index 6ae6810..c284d84 100644
--- a/arch/arm/plat-s5p/include/plat/ehci.h
+++ b/arch/arm/plat-samsung/include/plat/ehci.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef __PLAT_S5P_EHCI_H
-#define __PLAT_S5P_EHCI_H
+#ifndef __PLAT_SAMSUNG_EHCI_H
+#define __PLAT_SAMSUNG_EHCI_H __FILE__
 
 struct s5p_ehci_platdata {
 	int (*phy_init)(struct platform_device *pdev, int type);
@@ -18,4 +18,4 @@ struct s5p_ehci_platdata {
 
 extern void s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd);
 
-#endif /* __PLAT_S5P_EHCI_H */
+#endif /* __PLAT_SAMSUNG_EHCI_H */
diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-samsung/include/plat/irqs.h
similarity index 96%
rename from arch/arm/plat-s5p/include/plat/irqs.h
rename to arch/arm/plat-samsung/include/plat/irqs.h
index ba9121c..3c62a7a 100644
--- a/arch/arm/plat-s5p/include/plat/irqs.h
+++ b/arch/arm/plat-samsung/include/plat/irqs.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/irqs.h
+/* linux/arch/arm/plat-samsung/include/plat/irqs.h
  *
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -10,8 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_PLAT_S5P_IRQS_H
-#define __ASM_PLAT_S5P_IRQS_H __FILE__
+#ifndef __PLAT_SAMSUNG_IRQS_H
+#define __PLAT_SAMSUNG_IRQS_H __FILE__
 
 /* we keep the first set of CPU IRQs out of the range of
  * the ISA space, so that the PC104 has them to itself
@@ -112,4 +112,4 @@
 #define S5P_IRQ_TYPE_EDGE_RISING	(0x03)
 #define S5P_IRQ_TYPE_EDGE_BOTH		(0x04)
 
-#endif /* __ASM_PLAT_S5P_IRQS_H */
+#endif /* __PLAT_SAMSUNG_IRQS_H */
diff --git a/arch/arm/plat-s5p/include/plat/mfc.h b/arch/arm/plat-samsung/include/plat/mfc.h
similarity index 91%
rename from arch/arm/plat-s5p/include/plat/mfc.h
rename to arch/arm/plat-samsung/include/plat/mfc.h
index 6697f8c..08d14c3 100644
--- a/arch/arm/plat-s5p/include/plat/mfc.h
+++ b/arch/arm/plat-samsung/include/plat/mfc.h
@@ -7,8 +7,8 @@
  * option) any later version.
  */
 
-#ifndef __PLAT_S5P_MFC_H
-#define __PLAT_S5P_MFC_H
+#ifndef __PLAT_SAMSUNG_MFC_H
+#define __PLAT_SAMSUNG_MFC_H __FILE__
 
 /**
  * s5p_mfc_reserve_mem - function to early reserve memory for MFC driver
@@ -24,4 +24,4 @@
 void __init s5p_mfc_reserve_mem(phys_addr_t rbase, unsigned int rsize,
 				phys_addr_t lbase, unsigned int lsize);
 
-#endif /* __PLAT_S5P_MFC_H */
+#endif /* __PLAT_SAMSUNG_MFC_H */
diff --git a/arch/arm/plat-s5p/include/plat/mipi_csis.h b/arch/arm/plat-samsung/include/plat/mipi_csis.h
similarity index 91%
rename from arch/arm/plat-s5p/include/plat/mipi_csis.h
rename to arch/arm/plat-samsung/include/plat/mipi_csis.h
index 9bd254c..b02c076 100644
--- a/arch/arm/plat-s5p/include/plat/mipi_csis.h
+++ b/arch/arm/plat-samsung/include/plat/mipi_csis.h
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef PLAT_S5P_MIPI_CSIS_H_
-#define PLAT_S5P_MIPI_CSIS_H_ __FILE__
+#ifndef __PLAT_SAMSUNG_MIPI_CSIS_H_
+#define __PLAT_SAMSUNG_MIPI_CSIS_H_ __FILE__
 
 struct platform_device;
 
@@ -40,4 +40,4 @@ struct s5p_platform_mipi_csis {
  */
 int s5p_csis_phy_enable(struct platform_device *pdev, bool on);
 
-#endif /* PLAT_S5P_MIPI_CSIS_H_ */
+#endif /* __PLAT_SAMSUNG_MIPI_CSIS_H_ */
diff --git a/arch/arm/plat-s5p/include/plat/regs-srom.h b/arch/arm/plat-samsung/include/plat/regs-srom.h
similarity index 89%
rename from arch/arm/plat-s5p/include/plat/regs-srom.h
rename to arch/arm/plat-samsung/include/plat/regs-srom.h
index f121ab5..cf6a998 100644
--- a/arch/arm/plat-s5p/include/plat/regs-srom.h
+++ b/arch/arm/plat-samsung/include/plat/regs-srom.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/regs-srom.h
+/* linux/arch/arm/plat-samsung/include/plat/regs-srom.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -10,8 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_PLAT_S5P_REGS_SROM_H
-#define __ASM_PLAT_S5P_REGS_SROM_H __FILE__
+#ifndef __PLAT_SAMSUNG_REGS_SROM_H
+#define __PLAT_SAMSUNG_REGS_SROM_H __FILE__
 
 #include <mach/map.h>
 
@@ -51,4 +51,4 @@
 #define S5P_SROM_BCX__TCOS__SHIFT		24
 #define S5P_SROM_BCX__TACS__SHIFT		28
 
-#endif /* __ASM_PLAT_S5P_REGS_SROM_H */
+#endif /* __PLAT_SAMSUNG_REGS_SROM_H */
diff --git a/arch/arm/plat-s5p/include/plat/reset.h b/arch/arm/plat-samsung/include/plat/reset.h
similarity index 67%
rename from arch/arm/plat-s5p/include/plat/reset.h
rename to arch/arm/plat-samsung/include/plat/reset.h
index 335e978..b674415 100644
--- a/arch/arm/plat-s5p/include/plat/reset.h
+++ b/arch/arm/plat-samsung/include/plat/reset.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/reset.h
+/* linux/arch/arm/plat-samsung/include/plat/reset.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -8,9 +8,9 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_PLAT_S5P_RESET_H
-#define __ASM_PLAT_S5P_RESET_H __FILE__
+#ifndef __PLAT_SAMSUNG_RESET_H
+#define __PLAT_SAMSUNG_RESET_H __FILE__
 
 extern void (*s5p_reset_hook)(void);
 
-#endif /* __ASM_PLAT_S5P_RESET_H */
+#endif /* __PLAT_SAMSUNG_RESET_H */
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-samsung/include/plat/s5p-clock.h
similarity index 96%
rename from arch/arm/plat-s5p/include/plat/s5p-clock.h
rename to arch/arm/plat-samsung/include/plat/s5p-clock.h
index 769b5bd..984bf9e 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-samsung/include/plat/s5p-clock.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/s5p-clock.h
+/* linux/arch/arm/plat-samsung/include/plat/s5p-clock.h
  *
  * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/plat-s5p/include/plat/s5p-time.h b/arch/arm/plat-samsung/include/plat/s5p-time.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/s5p-time.h
rename to arch/arm/plat-samsung/include/plat/s5p-time.h
index 575e881..3a70aeb 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-time.h
+++ b/arch/arm/plat-samsung/include/plat/s5p-time.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/s5p-time.h
+/* linux/arch/arm/plat-samsung/include/plat/s5p-time.h
  *
  * Copyright 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/arch/arm/plat-s5p/include/plat/sysmmu.h b/arch/arm/plat-samsung/include/plat/sysmmu.h
similarity index 96%
rename from arch/arm/plat-s5p/include/plat/sysmmu.h
rename to arch/arm/plat-samsung/include/plat/sysmmu.h
index bf5283c..a05b9e2 100644
--- a/arch/arm/plat-s5p/include/plat/sysmmu.h
+++ b/arch/arm/plat-samsung/include/plat/sysmmu.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/sysmmu.h
+/* linux/arch/arm/plat-samsung/include/plat/sysmmu.h
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -10,8 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM__PLAT_SYSMMU_H
-#define __ASM__PLAT_SYSMMU_H __FILE__
+#ifndef __PLAT_SAMSUNG_SYSMMU_H
+#define __PLAT_SAMSUNG_SYSMMU_H __FILE__
 
 enum S5P_SYSMMU_INTERRUPT_TYPE {
 	SYSMMU_PAGEFAULT,
diff --git a/arch/arm/plat-s5p/include/plat/system-reset.h b/arch/arm/plat-samsung/include/plat/system-reset.h
similarity index 92%
rename from arch/arm/plat-s5p/include/plat/system-reset.h
rename to arch/arm/plat-samsung/include/plat/system-reset.h
index f307f34..a448e99 100644
--- a/arch/arm/plat-s5p/include/plat/system-reset.h
+++ b/arch/arm/plat-samsung/include/plat/system-reset.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/system-reset.h
+/* linux/arch/arm/plat-samsung/include/plat/system-reset.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/plat-s5p/include/plat/usb-phy.h b/arch/arm/plat-samsung/include/plat/usb-phy.h
similarity index 85%
rename from arch/arm/plat-s5p/include/plat/usb-phy.h
rename to arch/arm/plat-samsung/include/plat/usb-phy.h
index 6dd6bcf..9934f18 100644
--- a/arch/arm/plat-s5p/include/plat/usb-phy.h
+++ b/arch/arm/plat-samsung/include/plat/usb-phy.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef __PLAT_S5P_USB_PHY_H
-#define __PLAT_S5P_USB_PHY_H
+#ifndef __PLAT_SAMSUNG_USB_PHY_H
+#define __PLAT_SAMSUNG_USB_PHY_H __FILE__
 
 enum s5p_usb_phy_type {
 	S5P_USB_PHY_DEVICE,
@@ -19,4 +19,4 @@ enum s5p_usb_phy_type {
 extern int s5p_usb_phy_init(struct platform_device *pdev, int type);
 extern int s5p_usb_phy_exit(struct platform_device *pdev, int type);
 
-#endif /* __PLAT_S5P_REGS_USB_PHY_H */
+#endif /* __PLAT_SAMSUNG_USB_PHY_H */
-- 
1.7.1
