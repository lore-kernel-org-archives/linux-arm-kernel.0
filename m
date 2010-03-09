From: baruch@tkos.co.il (Baruch Siach)
Date: Tue,  9 Mar 2010 12:12:05 +0200
Subject: [PATCH 2/2] mx25: fix build when DEBUG_LL is enabled
In-Reply-To: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
References: <e5558b1571cff8472994ed51622339fd9e517f5e.1268129163.git.baruch@tkos.co.il>
Message-ID: <3936f84a5e18344d7562af43ca5f76d5e95f6642.1268129163.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex Greshgorin <alexg@orex-cr.com>

Commit "imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS" removed the
MX25_AIPS1_IO_ADDRESS macro which is used in debug-macro.S. Reintroduce this
macro.

Signed-off-by: Alex Greshgorin <alexg@orex-cr.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 4eb6e33..e2e35db 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -22,6 +22,10 @@
 #define MX25_GPIO3_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xa4000)
 #define MX25_GPIO4_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0x9c000)
 
+/* define macro needed for debug-macro.S */
+#define MX25_AIPS1_IO_ADDRESS(x)	\
+	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
+
 #define MX25_IO_ADDRESS(x) (					\
 	IMX_IO_ADDRESS(x, MX25_AIPS1) ?:			\
 	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
-- 
1.7.0
