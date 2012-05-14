From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 14 May 2012 21:46:09 +0400
Subject: [PATCH 2/4] ARM: clps711x: Added missing register definitions
In-Reply-To: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
References: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
Message-ID: <1337017571-16208-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/clps711x.h |   46 ++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index 3e07591..1dd806f 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -87,6 +87,14 @@
 #define LEDFLSH		(0x22c0)
 #define SDCONF		(0x2300)
 #define SDRFPR		(0x2340)
+#define UNIQID		(0x2440)
+#define DAI64FS		(0x2600)
+#define PLLW		(0x2610)
+#define PLLR		(0xa5a8)
+#define RANDID0		(0x2700)
+#define RANDID1		(0x2704)
+#define RANDID2		(0x2708)
+#define RANDID3		(0x270c)
 
 /* common bits: SYSCON1 / SYSCON2 */
 #define SYSCON_UARTEN		(1 << 8)
@@ -134,6 +142,8 @@
 #define SYSFLG1_CTXFF		(1 << 25)
 #define SYSFLG1_SSIBUSY		(1 << 26)
 #define SYSFLG1_ID		(1 << 29)
+#define SYSFLG1_VERID(x)	(((x) >> 30) & 3)
+#define SYSFLG1_VERID_MASK	(3 << 30)
 
 #define SYSFLG2_SSRXOF		(1 << 0)
 #define SYSFLG2_RESVAL		(1 << 1)
@@ -181,9 +191,12 @@
 #define UBRLCR_WRDLEN8		(3 << 17)
 #define UBRLCR_WRDLEN_MASK	(3 << 17)
 
+#define SYNCIO_FRMLEN(x)	(((x) & 0x3f) << 7)
+#define SYNCIO_CFGLEN(x)	((x) & 0x7f)
 #define SYNCIO_SMCKEN		(1 << 13)
 #define SYNCIO_TXFRMEN		(1 << 14)
 
+#define DAIR_RESERVED		(0x0404)
 #define DAIR_DAIEN		(1 << 16)
 #define DAIR_ECS		(1 << 17)
 #define DAIR_LCTM		(1 << 19)
@@ -210,11 +223,23 @@
 #define DAISR_LCNE		(1 << 11)
 #define DAISR_FIFO		(1 << 12)
 
+#define DAI64FS_I2SF64		(1 << 0)
+#define DAI64FS_AUDIOCLKEN	(1 << 1)
+#define DAI64FS_AUDIOCLKSRC	(1 << 2)
+#define DAI64FS_MCLK256EN	(1 << 3)
+#define DAI64FS_LOOPBACK	(1 << 5)
+
 #define SYSCON3_ADCCON		(1 << 0)
+#define SYSCON3_CLKCTL0		(1 << 1)
+#define SYSCON3_CLKCTL1		(1 << 2)
 #define SYSCON3_DAISEL		(1 << 3)
 #define SYSCON3_ADCCKNSEN	(1 << 4)
+#define SYSCON3_VERSN(x)	(((x) >> 5) & 7)
+#define SYSCON3_VERSN_MASK	(7 << 5)
 #define SYSCON3_FASTWAKE	(1 << 8)
 #define SYSCON3_DAIEN		(1 << 9)
+#define SYSCON3_128FS		SYSCON3_DAIEN
+#define SYSCON3_ENPD67		(1 << 10)
 
 #define SDCONF_ACTIVE		(1 << 10)
 #define SDCONF_CLKCTL		(1 << 9)
@@ -229,4 +254,25 @@
 #define SDCONF_CASLAT_2		(2)
 #define SDCONF_CASLAT_3		(3)
 
+#define MEMCFG_BUS_WIDTH_32	(1)
+#define MEMCFG_BUS_WIDTH_16	(0)
+#define MEMCFG_BUS_WIDTH_8	(3)
+
+#define MEMCFG_WAITSTATE_8_3	(0 << 2)
+#define MEMCFG_WAITSTATE_7_3	(1 << 2)
+#define MEMCFG_WAITSTATE_6_3	(2 << 2)
+#define MEMCFG_WAITSTATE_5_3	(3 << 2)
+#define MEMCFG_WAITSTATE_4_2	(4 << 2)
+#define MEMCFG_WAITSTATE_3_2	(5 << 2)
+#define MEMCFG_WAITSTATE_2_2	(6 << 2)
+#define MEMCFG_WAITSTATE_1_2	(7 << 2)
+#define MEMCFG_WAITSTATE_8_1	(8 << 2)
+#define MEMCFG_WAITSTATE_7_1	(9 << 2)
+#define MEMCFG_WAITSTATE_6_1	(10 << 2)
+#define MEMCFG_WAITSTATE_5_1	(11 << 2)
+#define MEMCFG_WAITSTATE_4_0	(12 << 2)
+#define MEMCFG_WAITSTATE_3_0	(13 << 2)
+#define MEMCFG_WAITSTATE_2_0	(14 << 2)
+#define MEMCFG_WAITSTATE_1_0	(15 << 2)
+
 #endif /* __MACH_CLPS711X_H */
-- 
1.7.3.4
