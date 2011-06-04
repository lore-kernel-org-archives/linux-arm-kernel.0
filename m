From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  4 Jun 2011 13:35:00 -0300
Subject: [PATCH v2] ARM: mx53: Fix alternate modes for MX53_PAD_PATA_DATA6
Message-ID: <1307205300-2084-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX53_PAD_PATA_DATA6 can have the following alternate modes:

PATA_DATA_6:  		mode 0
GPIO2_6:		mode 1
EMI_NANDF_D_6:		mode 3
ESDHC4_DAT6		mode 4
GPU3d_GPU_DEBUG_OUT_6	mode 5
IPU_DIAG_BUS_6		mode 6

Fix the modes accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Dinh Nguyen <dinh.nguyen@freescale.com>
---

Changes since v1:
- Improved subject and added a commit message

 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index e95d9cb..50b88a4 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -958,12 +958,12 @@
 #define _MX53_PAD_PATA_DATA5__ESDHC4_DAT5		IOMUX_PAD(0x63C, 0x2B8, 4, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA5__GPU3d_GPU_DEBUG_OUT_5	IOMUX_PAD(0x63C, 0x2B8, 5, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA5__IPU_DIAG_BUS_5	IOMUX_PAD(0x63C, 0x2B8, 6, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__PATA_DATA_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__PATA_DATA_6	IOMUX_PAD(0x640, 0x2BC, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA6__GPIO2_6		IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__EMI_NANDF_D_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__ESDHC4_DAT6		IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__GPU3d_GPU_DEBUG_OUT_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__IPU_DIAG_BUS_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__EMI_NANDF_D_6	IOMUX_PAD(0x640, 0x2BC, 3, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__ESDHC4_DAT6		IOMUX_PAD(0x640, 0x2BC, 4, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__GPU3d_GPU_DEBUG_OUT_6	IOMUX_PAD(0x640, 0x2BC, 5, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__IPU_DIAG_BUS_6	IOMUX_PAD(0x640, 0x2BC, 6, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__PATA_DATA_7		IOMUX_PAD(0x644, 0x2C0, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__GPIO2_7		IOMUX_PAD(0x644, 0x2C0, 1, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__EMI_NANDF_D_7	IOMUX_PAD(0x644, 0x2C0, 3, 0x0, 0, 0)
--
