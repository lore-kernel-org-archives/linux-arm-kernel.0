From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 21 Aug 2012 20:59:33 +0400
Subject: [PATCH 2/4] ARM: clps711x: Fix register definitions
In-Reply-To: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
Message-ID: <1345568375-28516-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contain some fixes:
- Fixes the address of register PORTE.
- Corrects name for DAIDR0 register.
- Removes unused definition for SYNCIO_CFGLEN.
- Fixes definition SYNCIO_FRMLEN.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/clps711x.h |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index 1dd806f..c82e21c 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -31,8 +31,8 @@
 #define PBDDR		(0x0041)
 #define PCDDR		(0x0042)
 #define PDDDR		(0x0043)
-#define PEDR		(0x0080)
-#define PEDDR		(0x00c0)
+#define PEDR		(0x0083)
+#define PEDDR		(0x00c3)
 #define SYSCON1		(0x0100)
 #define SYSFLG1		(0x0140)
 #define MEMCFG1		(0x0180)
@@ -77,7 +77,7 @@
 #define KBDEOI		(0x1700)
 
 #define DAIR		(0x2000)
-#define DAIR0		(0x2040)
+#define DAIDR0		(0x2040)
 #define DAIDR1		(0x2080)
 #define DAIDR2		(0x20c0)
 #define DAISR		(0x2100)
@@ -191,8 +191,7 @@
 #define UBRLCR_WRDLEN8		(3 << 17)
 #define UBRLCR_WRDLEN_MASK	(3 << 17)
 
-#define SYNCIO_FRMLEN(x)	(((x) & 0x3f) << 7)
-#define SYNCIO_CFGLEN(x)	((x) & 0x7f)
+#define SYNCIO_FRMLEN(x)	(((x) & 0x1f) << 8)
 #define SYNCIO_SMCKEN		(1 << 13)
 #define SYNCIO_TXFRMEN		(1 << 14)
 
-- 
1.7.8.6
