From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:35 +0200
Subject: [RFC PATCH 05/15] ARM: uncompress.h: Remove unused arch_decomp_setup
	declarations
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-5-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the decompressor code only calls this function
when ARCH_HAVE_DECOMP_SETUP is defined, the unused empty
declarations can go away.

As an added bonus, over 30 comments stating "nothing to do"
get deleted, making the ARM arch more busy than ever.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-at91/include/mach/uncompress.h       |    2 --
 arch/arm/mach-bcmring/include/mach/uncompress.h    |    2 --
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    5 -----
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-dove/include/mach/uncompress.h       |    5 -----
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-footbridge/include/mach/uncompress.h |    5 -----
 arch/arm/mach-gemini/include/mach/uncompress.h     |    5 -----
 arch/arm/mach-h720x/include/mach/uncompress.h      |    5 -----
 arch/arm/mach-integrator/include/mach/uncompress.h |    5 -----
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-ixp2000/include/mach/uncompress.h    |    2 --
 arch/arm/mach-ixp23xx/include/mach/uncompress.h    |    2 --
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    5 -----
 arch/arm/mach-ks8695/include/mach/uncompress.h     |    2 --
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    3 ---
 arch/arm/mach-msm/include/mach/uncompress.h        |    4 ----
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-netx/include/mach/uncompress.h       |    5 -----
 arch/arm/mach-nomadik/include/mach/uncompress.h    |    4 ----
 arch/arm/mach-orion5x/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |    1 -
 arch/arm/mach-pnx4008/include/mach/uncompress.h    |    5 -----
 arch/arm/mach-prima2/include/mach/uncompress.h     |    4 ----
 arch/arm/mach-realview/include/mach/uncompress.h   |    5 -----
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    5 -----
 arch/arm/mach-shark/include/mach/uncompress.h      |    5 -----
 arch/arm/mach-shmobile/include/mach/uncompress.h   |    4 ----
 arch/arm/mach-u300/include/mach/uncompress.h       |    5 -----
 arch/arm/mach-versatile/include/mach/uncompress.h  |    5 -----
 arch/arm/mach-vexpress/include/mach/uncompress.h   |    5 -----
 arch/arm/mach-vt8500/include/mach/uncompress.h     |    5 -----
 arch/arm/mach-w90x900/include/mach/uncompress.h    |    4 ----
 arch/arm/mach-zynq/include/mach/uncompress.h       |    4 ----
 arch/arm/plat-spear/include/plat/uncompress.h      |    5 -----
 arch/arm/plat-tcc/include/mach/uncompress.h        |    5 -----
 36 files changed, 0 insertions(+), 153 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index b5dd672..c644b13 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -69,6 +69,4 @@ static inline void flush(void)
 #endif
 }
 
-#define arch_decomp_setup()
-
 #endif
diff --git a/arch/arm/mach-bcmring/include/mach/uncompress.h b/arch/arm/mach-bcmring/include/mach/uncompress.h
index 5419901..7a365aa 100644
--- a/arch/arm/mach-bcmring/include/mach/uncompress.h
+++ b/arch/arm/mach-bcmring/include/mach/uncompress.h
@@ -38,5 +38,3 @@ static inline void flush(void)
 	while (BCMRING_UART_0_FR & (1 << 3))
 		;
 }
-
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 2edd488..3090a43 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -50,8 +50,3 @@ static inline void flush(void)
 	while (clps_readl(SYSFLGx) & SYSFLG_UBUSY)
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-cns3xxx/include/mach/uncompress.h b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
index 7a030b9..255a167 100644
--- a/arch/arm/mach-cns3xxx/include/mach/uncompress.h
+++ b/arch/arm/mach-cns3xxx/include/mach/uncompress.h
@@ -46,8 +46,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR(base) & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-dove/include/mach/uncompress.h
index 5c8ae9b..3bc22a1 100644
--- a/arch/arm/mach-dove/include/mach/uncompress.h
+++ b/arch/arm/mach-dove/include/mach/uncompress.h
@@ -29,8 +29,3 @@ static void putc(const char c)
 static void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-ebsa110/include/mach/uncompress.h b/arch/arm/mach-ebsa110/include/mach/uncompress.h
index ab64bea..507ec2a 100644
--- a/arch/arm/mach-ebsa110/include/mach/uncompress.h
+++ b/arch/arm/mach-ebsa110/include/mach/uncompress.h
@@ -37,8 +37,3 @@ static inline void flush(void)
 	} while ((v & (UART_LSR_TEMT|UART_LSR_THRE)) !=
 		 (UART_LSR_TEMT|UART_LSR_THRE));
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-footbridge/include/mach/uncompress.h b/arch/arm/mach-footbridge/include/mach/uncompress.h
index a69398c..36313de 100644
--- a/arch/arm/mach-footbridge/include/mach/uncompress.h
+++ b/arch/arm/mach-footbridge/include/mach/uncompress.h
@@ -30,8 +30,3 @@ static inline void putc(char c)
 static inline void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-gemini/include/mach/uncompress.h b/arch/arm/mach-gemini/include/mach/uncompress.h
index 02e2256..1828862 100644
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -34,9 +34,4 @@ static inline void flush(void)
 {
 }
 
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
 #endif /* __MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-h720x/include/mach/uncompress.h b/arch/arm/mach-h720x/include/mach/uncompress.h
index 43e343c..46c8d5a 100644
--- a/arch/arm/mach-h720x/include/mach/uncompress.h
+++ b/arch/arm/mach-h720x/include/mach/uncompress.h
@@ -28,9 +28,4 @@ static inline void flush(void)
 {
 }
 
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/uncompress.h b/arch/arm/mach-integrator/include/mach/uncompress.h
index 8f3cc99..9f61543 100644
--- a/arch/arm/mach-integrator/include/mach/uncompress.h
+++ b/arch/arm/mach-integrator/include/mach/uncompress.h
@@ -41,8 +41,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-iop13xx/include/mach/uncompress.h b/arch/arm/mach-iop13xx/include/mach/uncompress.h
index d3791ec..bfa8eac 100644
--- a/arch/arm/mach-iop13xx/include/mach/uncompress.h
+++ b/arch/arm/mach-iop13xx/include/mach/uncompress.h
@@ -15,8 +15,3 @@ static inline void putc(char c)
 static inline void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-ixp2000/include/mach/uncompress.h b/arch/arm/mach-ixp2000/include/mach/uncompress.h
index 126e5d7..519ba97 100644
--- a/arch/arm/mach-ixp2000/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp2000/include/mach/uncompress.h
@@ -42,5 +42,3 @@ static inline void putc(int c)
 static inline void flush(void)
 {
 }
-
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-ixp23xx/include/mach/uncompress.h b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
index 1ac7020..ab23cbb 100644
--- a/arch/arm/mach-ixp23xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp23xx/include/mach/uncompress.h
@@ -33,6 +33,4 @@ static inline void flush(void)
 {
 }
 
-#define arch_decomp_setup()
-
 #endif
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-kirkwood/include/mach/uncompress.h
index 5bca553..1fc91eb 100644
--- a/arch/arm/mach-kirkwood/include/mach/uncompress.h
+++ b/arch/arm/mach-kirkwood/include/mach/uncompress.h
@@ -39,8 +39,3 @@ static void flush(void)
 		barrier();
 	}
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index 9a54080..548c43b 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -31,6 +31,4 @@ static inline void flush(void)
 		barrier();
 }
 
-#define arch_decomp_setup()
-
 #endif
diff --git a/arch/arm/mach-lpc32xx/include/mach/uncompress.h b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
index 1198a89..36176e2 100644
--- a/arch/arm/mach-lpc32xx/include/mach/uncompress.h
+++ b/arch/arm/mach-lpc32xx/include/mach/uncompress.h
@@ -53,7 +53,4 @@ static inline void flush(void)
 		UART_FIFO_CTL_TX_RESET, _UARTREG(LPC32XX_UART_IIRFCR_O));
 }
 
-/* NULL functions; we don't presently need them */
-#define arch_decomp_setup()
-
 #endif
diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index 0fe7930..7fa472d 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -32,8 +32,4 @@ static inline void flush(void)
 {
 }
 
-static inline void arch_decomp_setup(void)
-{
-}
-
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
index 6a761c4..d26eb30 100644
--- a/arch/arm/mach-mv78xx0/include/mach/uncompress.h
+++ b/arch/arm/mach-mv78xx0/include/mach/uncompress.h
@@ -39,8 +39,3 @@ static void flush(void)
 		barrier();
 	}
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index 5cb1051..0e011ee 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -68,8 +68,3 @@ static inline void flush(void)
 
 	while (REG(base + UART_FR) & FR_BUSY);
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-nomadik/include/mach/uncompress.h b/arch/arm/mach-nomadik/include/mach/uncompress.h
index 765bff1..08f6615 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -54,8 +54,4 @@ static void flush(void)
 		barrier();
 }
 
-static inline void arch_decomp_setup(void)
-{
-}
-
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index abd26b5..a4dca1c 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -41,8 +41,3 @@ static void flush(void)
 		barrier();
 	}
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
index db46249..f04f368 100644
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ b/arch/arm/mach-picoxcell/include/mach/uncompress.h
@@ -17,4 +17,3 @@
  */
 #define putc(c)
 #define flush()
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-pnx4008/include/mach/uncompress.h b/arch/arm/mach-pnx4008/include/mach/uncompress.h
index 26b507d..add0c75 100644
--- a/arch/arm/mach-pnx4008/include/mach/uncompress.h
+++ b/arch/arm/mach-pnx4008/include/mach/uncompress.h
@@ -38,8 +38,3 @@ static __inline__ void putc(char c)
 static inline void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 1e17796..9ee022f 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -13,10 +13,6 @@
 #include <mach/hardware.h>
 #include <mach/uart.h>
 
-void arch_decomp_setup(void)
-{
-}
-
 static __inline__ void putc(char c)
 {
 	/*
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/include/mach/uncompress.h
index cfa30d2..9ba06e9 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/include/mach/uncompress.h
@@ -70,8 +70,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR(base) & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index a834962..55c9e59 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -42,8 +42,3 @@ static void putc(int c)
 static inline void flush(void)
 {
 }
-
-/*
- * Nothing to do for these
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
index a168435..40f4b68 100644
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ b/arch/arm/mach-shark/include/mach/uncompress.h
@@ -43,8 +43,3 @@ static void putr()
 	putc('\r');
 }
 #endif
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
index f1aee56..b2b2860 100644
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ b/arch/arm/mach-shmobile/include/mach/uncompress.h
@@ -12,8 +12,4 @@ static inline void flush(void)
 {
 }
 
-static void arch_decomp_setup(void)
-{
-}
-
 #endif /* __ASM_MACH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-u300/include/mach/uncompress.h b/arch/arm/mach-u300/include/mach/uncompress.h
index 783e7e6..68d0298 100644
--- a/arch/arm/mach-u300/include/mach/uncompress.h
+++ b/arch/arm/mach-u300/include/mach/uncompress.h
@@ -38,8 +38,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-versatile/include/mach/uncompress.h b/arch/arm/mach-versatile/include/mach/uncompress.h
index 986e3d3..164b9b5 100644
--- a/arch/arm/mach-versatile/include/mach/uncompress.h
+++ b/arch/arm/mach-versatile/include/mach/uncompress.h
@@ -38,8 +38,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index a16872b..0f85a648 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -44,8 +44,3 @@ static inline void flush(void)
 	while (AMBA_UART_FR(base) & (1 << 3))
 		barrier();
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index 14ec0ec..6b93a01 100644
--- a/arch/arm/mach-vt8500/include/mach/uncompress.h
+++ b/arch/arm/mach-vt8500/include/mach/uncompress.h
@@ -29,8 +29,3 @@ static void putc(const char c)
 static void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 4b7c324..935d950 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -41,8 +41,4 @@ static inline void flush(void)
 {
 }
 
-static void arch_decomp_setup(void)
-{
-}
-
 #endif/* __ASM_W90X900_UNCOMPRESS_H */
diff --git a/arch/arm/mach-zynq/include/mach/uncompress.h b/arch/arm/mach-zynq/include/mach/uncompress.h
index 11c3216..623cebe 100644
--- a/arch/arm/mach-zynq/include/mach/uncompress.h
+++ b/arch/arm/mach-zynq/include/mach/uncompress.h
@@ -20,10 +20,6 @@
 #include <mach/zynq_soc.h>
 #include <mach/uart.h>
 
-void arch_decomp_setup(void)
-{
-}
-
 static inline void flush(void)
 {
 	/*
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index b631aab..317cfe4 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -34,9 +34,4 @@ static inline void flush(void)
 {
 }
 
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-
 #endif /* __PLAT_UNCOMPRESS_H */
diff --git a/arch/arm/plat-tcc/include/mach/uncompress.h b/arch/arm/plat-tcc/include/mach/uncompress.h
index 2e9c2bb..35a924e 100644
--- a/arch/arm/plat-tcc/include/mach/uncompress.h
+++ b/arch/arm/plat-tcc/include/mach/uncompress.h
@@ -26,8 +26,3 @@ static void putc(int c)
 static inline void flush(void)
 {
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-- 
1.7.4.1
