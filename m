From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 14:23:56 +0200
Subject: [PATCH 2/3] mx25: fix compile error in platform-imx-dma.c
In-Reply-To: <1286886237-29014-1-git-send-email-eric@eukrea.com>
References: <1286886237-29014-1-git-send-email-eric@eukrea.com>
Message-ID: <1286886237-29014-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch fix the following errors :
arch/arm/plat-mxc/devices/platform-imx-dma.c:44:
    error: ?MX25_SDMA_BASE_ADDR? undeclared here (not in a function)
arch/arm/plat-mxc/devices/platform-imx-dma.c:44:
    error: ?MX25_INT_SDMA? undeclared here (not in a function)

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 31d9c4c..02d0ecd 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -54,6 +54,7 @@
 #define MX25_MMC_SDHC2_BASE_ADDR	0x53fb8000
 #define MX25_LCDC_BASE_ADDR		0x53fbc000
 #define MX25_KPP_BASE_ADDR		0x43fa8000
+#define MX25_SDMA_BASE_ADDR		0x53fd4000
 #define MX25_OTG_BASE_ADDR		0x53ff4000
 #define MX25_CSI_BASE_ADDR		0x53ff8000
 
@@ -74,6 +75,7 @@
 #define MX25_INT_DRYICE		25
 #define MX25_INT_UART2		32
 #define MX25_INT_NFC		33
+#define MX25_INT_SDMA		34
 #define MX25_INT_LCDC		39
 #define MX25_INT_UART5		40
 #define MX25_INT_CAN1		43
-- 
1.7.0.4
