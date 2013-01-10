From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 22:12:44 +0800
Subject: [PATCH 2/3] ARM: remove unused arch_decomp_wdog()
In-Reply-To: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1357827165-9320-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARCH_HAS_DECOMP_WDOG removed from arch/arm/boot/compressed/decompress.c,
all the arch_decomp_wdog() definition at platform level is unneeded.
Remmove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-at91/include/mach/uncompress.h       |    2 --
 arch/arm/mach-bcm2835/include/mach/uncompress.h    |    1 -
 arch/arm/mach-clps711x/include/mach/uncompress.h   |    2 --
 arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-davinci/include/mach/uncompress.h    |    1 -
 arch/arm/mach-dove/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-footbridge/include/mach/uncompress.h |    1 -
 arch/arm/mach-gemini/include/mach/uncompress.h     |    2 --
 arch/arm/mach-h720x/include/mach/uncompress.h      |    1 -
 arch/arm/mach-integrator/include/mach/uncompress.h |    2 --
 arch/arm/mach-iop13xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-iop32x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-iop33x/include/mach/uncompress.h     |    1 -
 arch/arm/mach-ixp4xx/include/mach/uncompress.h     |    2 --
 arch/arm/mach-kirkwood/include/mach/uncompress.h   |    1 -
 arch/arm/mach-ks8695/include/mach/uncompress.h     |    1 -
 arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mmp/include/mach/uncompress.h        |    6 ------
 arch/arm/mach-msm/include/mach/uncompress.h        |    4 ----
 arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    1 -
 arch/arm/mach-mxs/include/mach/uncompress.h        |    1 -
 arch/arm/mach-netx/include/mach/uncompress.h       |    1 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |    2 --
 arch/arm/mach-omap1/include/mach/uncompress.h      |    5 -----
 arch/arm/mach-omap2/include/mach/uncompress.h      |    5 -----
 arch/arm/mach-orion5x/include/mach/uncompress.h    |    1 -
 arch/arm/mach-prima2/include/mach/uncompress.h     |    2 --
 arch/arm/mach-pxa/include/mach/uncompress.h        |    5 -----
 arch/arm/mach-realview/include/mach/uncompress.h   |    1 -
 arch/arm/mach-rpc/include/mach/uncompress.h        |    5 -----
 arch/arm/mach-sa1100/include/mach/uncompress.h     |    1 -
 arch/arm/mach-shark/include/mach/uncompress.h      |    1 -
 arch/arm/mach-shmobile/include/mach/uncompress.h   |    2 --
 arch/arm/mach-tegra/include/mach/uncompress.h      |    4 ----
 arch/arm/mach-u300/include/mach/uncompress.h       |    1 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |    2 --
 arch/arm/mach-versatile/include/mach/uncompress.h  |    1 -
 arch/arm/mach-vt8500/include/mach/uncompress.h     |    1 -
 arch/arm/mach-w90x900/include/mach/uncompress.h    |    2 --
 arch/arm/plat-spear/include/plat/uncompress.h      |    1 -
 42 files changed, 80 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 97ad68a..5659f7c 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -196,6 +196,4 @@ static inline void flush(void)
 		barrier();
 }
 
-#define arch_decomp_wdog()
-
 #endif
diff --git a/arch/arm/mach-bcm2835/include/mach/uncompress.h b/arch/arm/mach-bcm2835/include/mach/uncompress.h
index cc46dcc..bf86dca 100644
--- a/arch/arm/mach-bcm2835/include/mach/uncompress.h
+++ b/arch/arm/mach-bcm2835/include/mach/uncompress.h
@@ -42,4 +42,3 @@ static inline void flush(void)
 }
 
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-clps711x/include/mach/uncompress.h b/arch/arm/mach-clps711x/include/mach/uncompress.h
index 7b28d6a..5f02d06 100644
--- a/arch/arm/mach-clps711x/include/mach/uncompress.h
+++ b/arch/arm/mach-clps711x/include/mach/uncompress.h
@@ -53,5 +53,3 @@ static inline void flush(void)
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
index 3a0ff90..f49c2916 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -101,4 +101,3 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
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
index d64274f..d2afb4d 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -86,5 +86,3 @@ static void arch_decomp_setup(void)
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
index 8879d61..c089a1a 100644
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
index c14011f..fa97a10 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -60,8 +60,4 @@ static inline void arch_decomp_setup(void)
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
index ef28114..533f518 100644
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
index 7d4687e..f527af6 100644
--- a/arch/arm/mach-nomadik/include/mach/uncompress.h
+++ b/arch/arm/mach-nomadik/include/mach/uncompress.h
@@ -58,6 +58,4 @@ static inline void arch_decomp_setup(void)
 {
 }
 
-#define arch_decomp_wdog() /* nothing to do here */
-
 #endif /* __ASM_ARCH_UNCOMPRESS_H */
diff --git a/arch/arm/mach-omap1/include/mach/uncompress.h b/arch/arm/mach-omap1/include/mach/uncompress.h
index ad6fbe7..4869633 100644
--- a/arch/arm/mach-omap1/include/mach/uncompress.h
+++ b/arch/arm/mach-omap1/include/mach/uncompress.h
@@ -115,8 +115,3 @@ static inline void arch_decomp_setup(void)
 		DEBUG_LL_OMAP1(3, sx1);
 	} while (0);
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
index 8e3546d..7b360ac 100644
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -169,8 +169,3 @@ static inline void arch_decomp_setup(void)
 		DEBUG_LL_AM33XX(1, am335xevm);
 	} while (0);
 }
-
-/*
- * nothing to do
- */
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion5x/include/mach/uncompress.h
index 4322dba..abd26b5 100644
--- a/arch/arm/mach-orion5x/include/mach/uncompress.h
+++ b/arch/arm/mach-orion5x/include/mach/uncompress.h
@@ -46,4 +46,3 @@ static void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 0c898fc..f72ca26 100644
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
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index 5cf71da..73093dc 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -49,4 +49,3 @@ static inline void flush(void)
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
index 485003f..0838641 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -172,8 +172,4 @@ static inline void arch_decomp_setup(void)
 	uart[UART_LCR << DEBUG_UART_SHIFT] = 3;
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
index d60ecd1..36969d5 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -54,6 +54,4 @@ static inline void arch_decomp_setup(void)
 	ux500_uart_base = (void __iomem *)U8500_UART2_BASE;
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
diff --git a/arch/arm/mach-vt8500/include/mach/uncompress.h b/arch/arm/mach-vt8500/include/mach/uncompress.h
index e6e81fd..5b4f19e 100644
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
 
diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 2ce6cb1..51b2dc9 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -38,6 +38,5 @@ static inline void flush(void)
  * nothing to do
  */
 #define arch_decomp_setup()
-#define arch_decomp_wdog()
 
 #endif /* __PLAT_UNCOMPRESS_H */
-- 
1.7.9.5
