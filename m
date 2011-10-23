From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:31 +0200
Subject: [RFC PATCH 01/15] ARM: uncompress.h: Remove unused arch_decomp_wdog
	defines
Message-ID: <1319404245-12740-1-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_decomp_wdog is only used by lib/inflate.c which isn't used
by the ARM arch since 2.6.33.
Stop carrying it around and re-adding it with every new machine.

The only real user was the Samsung platform, but since this
feature wasn't working for over a year, it's probably
not needed at all.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-at91/include/mach/uncompress.h       |    2 -
 arch/arm/mach-bcmring/include/mach/uncompress.h    |    1 -
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    2 -
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-davinci/include/mach/uncompress.h    |    1 -
 arch/arm/mach-dove/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |    2 -
 arch/arm/mach-footbridge/include/mach/uncompress.h |    1 -
 arch/arm/mach-gemini/include/mach/uncompress.h     |    2 -
 arch/arm/mach-h720x/include/mach/uncompress.h      |    1 -
 arch/arm/mach-integrator/include/mach/uncompress.h |    2 -
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-iop32x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-iop33x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |    1 -
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |    2 -
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |    2 -
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    1 -
 arch/arm/mach-ks8695/include/mach/uncompress.h     |    1 -
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mmp/include/mach/uncompress.h        |    6 ---
 arch/arm/mach-msm/include/mach/uncompress.h        |    4 --
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mxs/include/mach/uncompress.h        |    1 -
 arch/arm/mach-netx/include/mach/uncompress.h       |    1 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |    2 -
 arch/arm/mach-orion5x/include/mach/uncompress.h    |    1 -
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |    1 -
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |    1 -
 arch/arm/mach-prima2/include/mach/uncompress.h     |    2 -
 arch/arm/mach-pxa/include/mach/uncompress.h        |    5 ---
 arch/arm/mach-realview/include/mach/uncompress.h   |    1 -
 arch/arm/mach-rpc/include/mach/uncompress.h        |    5 ---
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |   33 --------------------
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    1 -
 arch/arm/mach-shark/include/mach/uncompress.h      |    1 -
 arch/arm/mach-shmobile/include/mach/uncompress.h   |    2 -
 arch/arm/mach-tegra/include/mach/uncompress.h      |    4 --
 arch/arm/mach-u300/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    2 -
 arch/arm/mach-versatile/include/mach/uncompress.h  |    1 -
 arch/arm/mach-vexpress/include/mach/uncompress.h   |    1 -
 arch/arm/mach-vt8500/include/mach/uncompress.h     |    1 -
 arch/arm/mach-w90x900/include/mach/uncompress.h    |    2 -
 arch/arm/mach-zynq/include/mach/uncompress.h       |    2 -
 arch/arm/plat-mxc/include/mach/uncompress.h        |    1 -
 arch/arm/plat-omap/include/plat/uncompress.h       |    5 ---
 arch/arm/plat-samsung/Kconfig                      |    8 -----
 arch/arm/plat-samsung/include/plat/uncompress.h    |   33 --------------------
 arch/arm/plat-spear/include/plat/uncompress.h      |    1 -
 arch/arm/plat-tcc/include/mach/uncompress.h        |    1 -
 52 files changed, 0 insertions(+), 159 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 18bdcde..b5dd672 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -71,6 +71,4 @@ static inline void flush(void)
 
 #define arch_decomp_setup()
 
-#define arch_decomp_wdog()
-
 #endif
diff --git a/arch/arm/mach-bcmring/include/mach/uncompress.h b/arch/arm/mach-bcmring/include/mach/uncompress.h
index 9c9821b..5419901 100644
--- a/arch/arm/mach-bcmring/include/mach/uncompress.h
+++ b/arch/arm/mach-bcmring/include/mach/uncompress.h
@@ -40,4 +40,3 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 7164310..2edd488 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -55,5 +55,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index a91b605..7a030b9 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -51,4 +51,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 9dc7cf9..8d63753 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -103,4 +103,3 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 }
 
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 2c5cdd7..5c8ae9b 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -34,4 +34,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ebsa110/include/mach/uncompress.h b/arch/arm/mach-ebsa110/include/mach/uncompress.h
index 3204150..ab64bea 100644
--- a/arch/arm/mach-ebsa110/include/mach/uncompress.h
+++ b/arch/arm/mach-ebsa110/include/mach/uncompress.h
@@ -42,4 +42,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index 16026c2..b2ecb98 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -90,5 +90,3 @@ static void arch_decomp_setup(void)
 {
 	ethernet_reset();
 }
-
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
index 5dfa442..a69398c 100644
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ b/arch/arm/mach-footbridge/include/mach/uncompress.h
@@ -35,4 +35,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index 0efa262..02e2256 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -39,6 +39,4 @@ static inline void flush(void)
  */
 #define arch_decomp_setup()
 
-#define arch_decomp_wdog()
-
 #endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-h720x/include/mach/uncompress.h b/arch/arm/mach-h720x/include/mach/uncompress.h
index d662323..43e343c 100644
--- a/arch/arm/mach-h720x/include/mach/uncompress.h
+++ b/arch/arm/mach-h720x/include/mach/uncompress.h
@@ -32,6 +32,5 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
 
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
index 30452f0..8f3cc99 100644
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ b/arch/arm/mach-integrator/include/mach/uncompress.h
@@ -46,5 +46,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-iop13xx/include/mach/uncompress.h b/arch/arm/mach-iop13xx/include/mach/uncompress.h
index fa4f805..d3791ec 100644
--- a/arch/arm/mach-iop13xx/include/mach/uncompress.h
+++ b/arch/arm/mach-iop13xx/include/mach/uncompress.h
@@ -20,4 +20,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index 4fd7154..b3d45fd 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -36,4 +36,3 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
  * nothing to do
  */
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index f99bb84..ed282e1 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -34,4 +34,3 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
  * nothing to do
  */
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ixp2000/include/mach/uncompress.h b/arch/arm/mach-ixp2000/include/mach/uncompress.h
index ce36308..126e5d7 100644
--- a/arch/arm/mach-ixp2000/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp2000/include/mach/uncompress.h
@@ -44,4 +44,3 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ixp23xx/include/mach/uncompress.h b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
index 8b4c358..1ac7020 100644
--- a/arch/arm/mach-ixp23xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
@@ -34,7 +34,5 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
-
 
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index eb945a9..7b25c02 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -53,6 +53,4 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
  */
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
 
-#define arch_decomp_wdog()
-
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
index 75d5497..5bca553 100644
--- a/arch/arm/mach-kirkwood/include/mach/uncompress.h
+++ b/arch/arm/mach-kirkwood/include/mach/uncompress.h
@@ -44,4 +44,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index 9495cb4..9a54080 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -32,6 +32,5 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
 
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index c142487..1198a89 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -55,6 +55,5 @@ static inline void flush(void)
 
 /* NULL functions; we don't presently need them */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
 
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index d6daeb7..8890fa8 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -43,9 +43,3 @@ static inline void arch_decomp_setup(void)
 	if (machine_is_avengers_lite())
 		UART = (unsigned long *)UART3_BASE;
 }
-
-/*
- * nothing to do
- */
-
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index d94292c..0fe7930 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -36,8 +36,4 @@ static inline void arch_decomp_setup(void)
 {
 }
 
-static inline void arch_decomp_wdog(void)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index 3652642..6a761c4 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -44,4 +44,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index 7f8bf65..6ab8972 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -72,6 +72,5 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 }
 
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
 
 #endif /* __MACH_MXS_UNCOMPRESS_H__ */
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index 84f9128..5cb1051 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -73,4 +73,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index 071003b..765bff1 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -58,6 +58,4 @@ static inline void arch_decomp_setup(void)
 {
 }
 
-#define arch_decomp_wdog() /* nothing to do here */
-
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index 4322dba..abd26b5 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -46,4 +46,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
index b60b19d..db46249 100644
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -18,4 +18,3 @@
 #define putc(c)
 #define flush()
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-pnx4008/include/mach/uncompress.h b/arch/arm/mach-pnx4008/include/mach/uncompress.h
index bb4751e..26b507d 100644
--- a/arch/arm/mach-pnx4008/include/mach/uncompress.h
+++ b/arch/arm/mach-pnx4008/include/mach/uncompress.h
@@ -43,4 +43,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 83125c6..1e17796 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -17,8 +17,6 @@ void arch_decomp_setup(void)
 {
 }
 
-#define arch_decomp_wdog()
-
 static __inline__ void putc(char c)
 {
 	/*
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 5519a34..8c27757 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -72,8 +72,3 @@ static inline void arch_decomp_setup(void)
 		uart_is_pxa = 0;
 	}
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/include/mach/uncompress.h
index 83050378..cfa30d2 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/include/mach/uncompress.h
@@ -75,4 +75,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 9cd9bcd..0fd4b0b 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -189,8 +189,3 @@ static void arch_decomp_setup(void)
 	if (nr_pages * page_size < 4096*1024) error("<4M of mem\n");
 }
 #endif
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 1608faf..00b70b8 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -36,10 +36,6 @@ static void arch_detect_cpu(void);
 #include <plat/regs-serial.h>
 #include <plat/regs-watchdog.h>
 
-/* working in physical space... */
-#undef S3C2410_WDOGREG
-#define S3C2410_WDOGREG(x) ((S3C24XX_PA_WATCHDOG + (x)))
-
 /* how many bytes we allow into the FIFO at a time in FIFO mode */
 #define FIFO_MAX	 (14)
 
@@ -116,34 +112,6 @@ static inline void flush(void)
 		*((volatile unsigned int __force *)(ad)) = (d); \
 	} while (0)
 
-/*
- * CONFIG_S3C_BOOT_WATCHDOG
- *
- * Simple boot-time watchdog setup, to reboot the system if there is
- * any problem with the boot process
- */
-
-#ifdef CONFIG_S3C_BOOT_WATCHDOG
-
-#define WDOG_COUNT (0xff00)
-
-static inline void arch_decomp_wdog(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-}
-
-static void arch_decomp_wdog_start(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTDAT);
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x80), S3C2410_WTCON);
-}
-
-#else
-#define arch_decomp_wdog_start()
-#define arch_decomp_wdog()
-#endif
-
 #ifdef CONFIG_S3C_BOOT_ERROR_RESET
 
 static void arch_decomp_error(const char *x)
@@ -192,7 +160,6 @@ static void arch_decomp_setup(void)
 	 */
 
 	arch_detect_cpu();
-	arch_decomp_wdog_start();
 
 	/*
 	 * Enable the UART FIFOs if they where not enabled and our
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index 6cb39dd..a834962 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -47,4 +47,3 @@ static inline void flush(void)
  * Nothing to do for these
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
index 22ccab4..a168435 100644
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ b/arch/arm/mach-shark/include/mach/uncompress.h
@@ -48,4 +48,3 @@ static void putr()
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
index 0bd7556..f1aee56 100644
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ b/arch/arm/mach-shmobile/include/mach/uncompress.h
@@ -16,6 +16,4 @@ static void arch_decomp_setup(void)
 {
 }
 
-#define arch_decomp_wdog()
-
 #endif /* __ASM_MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 4e83237..565daa6 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -57,8 +57,4 @@ static inline void arch_decomp_setup(void)
 	uart[UART_LCR << shift] = 3;
 }
 
-static inline void arch_decomp_wdog(void)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
index 29acb71..783e7e6 100644
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ b/arch/arm/mach-u300/include/mach/uncompress.h
@@ -43,4 +43,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 6fb3c4b..ec957e8 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -57,6 +57,4 @@ static inline void arch_decomp_setup(void)
 		ux500_uart_base = U8500_UART2_BASE;
 }
 
-#define arch_decomp_wdog() /* nothing to do here */
-
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
index 3dd0048..986e3d3 100644
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ b/arch/arm/mach-versatile/include/mach/uncompress.h
@@ -43,4 +43,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 7972c57..a16872b 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -49,4 +49,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index bb9e2d2..14ec0ec 100644
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -34,4 +34,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 0313021..4b7c324 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -24,8 +24,6 @@
 #include <mach/map.h>
 #include <linux/serial_reg.h>
 
-#define arch_decomp_wdog()
-
 #define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
 static volatile u32 * const uart_base = (u32 *)UART0_PA;
 
diff --git a/arch/arm/mach-zynq/include/mach/uncompress.h b/arch/arm/mach-zynq/include/mach/uncompress.h
index af4e844..11c3216 100644
--- a/arch/arm/mach-zynq/include/mach/uncompress.h
+++ b/arch/arm/mach-zynq/include/mach/uncompress.h
@@ -34,8 +34,6 @@ static inline void flush(void)
 		cpu_relax();
 }
 
-#define arch_decomp_wdog()
-
 static void putc(char ch)
 {
 	/*
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 88fd404..d9412a1 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -126,6 +126,5 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 }
 
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
 
 #endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 2f472e9..c5111bd 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -183,8 +183,3 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 }
 
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 49a134f..6c49c35 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -19,14 +19,6 @@ if PLAT_SAMSUNG
 
 comment "Boot options"
 
-config S3C_BOOT_WATCHDOG
-	bool "S3C Initialisation watchdog"
-	depends on S3C2410_WATCHDOG
-	help
-	  Say y to enable the watchdog during the kernel decompression
-	  stage. If the kernel fails to uncompress, then the watchdog
-	  will trigger a reset and the system should restart.
-
 config S3C_BOOT_ERROR_RESET
 	bool "S3C Reboot on decompression error"
 	help
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index ee48e12..94fecf9 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -30,10 +30,6 @@ static void arch_detect_cpu(void);
 #include <plat/regs-serial.h>
 #include <plat/regs-watchdog.h>
 
-/* working in physical space... */
-#undef S3C2410_WDOGREG
-#define S3C2410_WDOGREG(x) ((S3C24XX_PA_WATCHDOG + (x)))
-
 /* how many bytes we allow into the FIFO at a time in FIFO mode */
 #define FIFO_MAX	 (14)
 
@@ -95,33 +91,6 @@ static inline void flush(void)
 		*((volatile unsigned int __force *)(ad)) = (d); \
 	} while (0)
 
-/* CONFIG_S3C_BOOT_WATCHDOG
- *
- * Simple boot-time watchdog setup, to reboot the system if there is
- * any problem with the boot process
-*/
-
-#ifdef CONFIG_S3C_BOOT_WATCHDOG
-
-#define WDOG_COUNT (0xff00)
-
-static inline void arch_decomp_wdog(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-}
-
-static void arch_decomp_wdog_start(void)
-{
-	__raw_writel(WDOG_COUNT, S3C2410_WTDAT);
-	__raw_writel(WDOG_COUNT, S3C2410_WTCNT);
-	__raw_writel(S3C2410_WTCON_ENABLE | S3C2410_WTCON_DIV128 | S3C2410_WTCON_RSTEN | S3C2410_WTCON_PRESCALE(0x80), S3C2410_WTCON);
-}
-
-#else
-#define arch_decomp_wdog_start()
-#define arch_decomp_wdog()
-#endif
-
 #ifdef CONFIG_S3C_BOOT_ERROR_RESET
 
 static void arch_decomp_error(const char *x)
@@ -161,7 +130,6 @@ static inline void arch_enable_uart_fifo(void)
 #define arch_enable_uart_fifo() do { } while(0)
 #endif
 
-
 static void
 arch_decomp_setup(void)
 {
@@ -171,7 +139,6 @@ arch_decomp_setup(void)
 	 */
 
 	arch_detect_cpu();
-	arch_decomp_wdog_start();
 
 	/* Enable the UART FIFOs if they where not enabled and our
 	 * configuration says we should turn them on.
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 1bf8452..b631aab 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -38,6 +38,5 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
 
 #endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
index 7a3e33a..2e9c2bb 100644
--- a/arch/arm/plat-tcc/include/mach/uncompress.h
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -31,4 +31,3 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
-- 
1.7.4.1
