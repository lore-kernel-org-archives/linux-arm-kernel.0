From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:33 +0200
Subject: [RFC PATCH 03/15] ARM: uncompress.h: Introduce ARCH_HAVE_DECOMP_SETUP
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-3-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add this define to machines which really make use of
this function.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
 arch/arm/mach-ep93xx/include/mach/uncompress.h  |    1 +
 arch/arm/mach-iop32x/include/mach/uncompress.h  |    4 +---
 arch/arm/mach-iop33x/include/mach/uncompress.h  |    4 +---
 arch/arm/mach-ixp4xx/include/mach/uncompress.h  |    1 +
 arch/arm/mach-mmp/include/mach/uncompress.h     |    2 ++
 arch/arm/mach-mxs/include/mach/uncompress.h     |    1 +
 arch/arm/mach-pxa/include/mach/uncompress.h     |    2 ++
 arch/arm/mach-rpc/include/mach/uncompress.h     |    2 ++
 arch/arm/mach-s5p64x0/include/mach/uncompress.h |    2 ++
 arch/arm/mach-tegra/include/mach/uncompress.h   |    2 ++
 arch/arm/mach-ux500/include/mach/uncompress.h   |    2 ++
 arch/arm/plat-mxc/include/mach/uncompress.h     |    1 +
 arch/arm/plat-omap/include/plat/uncompress.h    |    1 +
 arch/arm/plat-samsung/include/plat/uncompress.h |    2 ++
 15 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 8d63753..1947ff9 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -102,4 +102,5 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 	} while (0);
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-ep93xx/include/mach/uncompress.h b/arch/arm/mach-ep93xx/include/mach/uncompress.h
index b2ecb98..f1cd638 100644
--- a/arch/arm/mach-ep93xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ep93xx/include/mach/uncompress.h
@@ -85,6 +85,7 @@ static void ethernet_reset(void)
 		;
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
 
 static void arch_decomp_setup(void)
 {
diff --git a/arch/arm/mach-iop32x/include/mach/uncompress.h b/arch/arm/mach-iop32x/include/mach/uncompress.h
index b3d45fd..c1ff29a 100644
--- a/arch/arm/mach-iop32x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop32x/include/mach/uncompress.h
@@ -32,7 +32,5 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		uart_base = (volatile u8 *)0xfe800000;
 }
 
-/*
- * nothing to do
- */
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-iop33x/include/mach/uncompress.h b/arch/arm/mach-iop33x/include/mach/uncompress.h
index ed282e1..9537d4b 100644
--- a/arch/arm/mach-iop33x/include/mach/uncompress.h
+++ b/arch/arm/mach-iop33x/include/mach/uncompress.h
@@ -30,7 +30,5 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 		uart_base = (volatile u32 *)0xfe800000;
 }
 
-/*
- * nothing to do
- */
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-ixp4xx/include/mach/uncompress.h b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
index 7b25c02..0a0102c 100644
--- a/arch/arm/mach-ixp4xx/include/mach/uncompress.h
+++ b/arch/arm/mach-ixp4xx/include/mach/uncompress.h
@@ -51,6 +51,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 /*
  * arch_id is a variable in decompress_kernel()
  */
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
 
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
index 8890fa8..8c58b57 100644
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ b/arch/arm/mach-mmp/include/mach/uncompress.h
@@ -35,6 +35,8 @@ static inline void flush(void)
 {
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static inline void arch_decomp_setup(void)
 {
 	/* default to UART2 */
diff --git a/arch/arm/mach-mxs/include/mach/uncompress.h b/arch/arm/mach-mxs/include/mach/uncompress.h
index 6ab8972..eded40b 100644
--- a/arch/arm/mach-mxs/include/mach/uncompress.h
+++ b/arch/arm/mach-mxs/include/mach/uncompress.h
@@ -71,6 +71,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 	}
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
 
 #endif /* __MACH_MXS_UNCOMPRESS_H__ */
diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 8c27757..28acded 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -54,6 +54,8 @@ static inline void flush(void)
 {
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static inline void arch_decomp_setup(void)
 {
 	/* initialize to default */
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 0fd4b0b..5ea3974 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -109,6 +109,8 @@ static inline void flush(void)
 {
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 /*
  * Setup for decompression
  */
diff --git a/arch/arm/mach-s5p64x0/include/mach/uncompress.h b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
index 00b70b8..8d537eb 100644
--- a/arch/arm/mach-s5p64x0/include/mach/uncompress.h
+++ b/arch/arm/mach-s5p64x0/include/mach/uncompress.h
@@ -151,6 +151,8 @@ static inline void arch_enable_uart_fifo(void)
 #define arch_enable_uart_fifo() do { } while(0)
 #endif
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static void arch_decomp_setup(void)
 {
 	/*
diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index 565daa6..1b07047 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -43,6 +43,8 @@ static inline void flush(void)
 {
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static inline void arch_decomp_setup(void)
 {
 	volatile u8 *uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index ec957e8..d096c99 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -48,6 +48,8 @@ static void flush(void)
 		barrier();
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static inline void arch_decomp_setup(void)
 {
 	/* Check in run time if we run on an U8500 or U5500 */
diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index d9412a1..6e43f5e 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -125,6 +125,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	}
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
 
 #endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index c5111bd..860c02b 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -182,4 +182,5 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 	} while (0);
 }
 
+#define ARCH_HAVE_DECOMP_SETUP
 #define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index 94fecf9..b10e0be 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -130,6 +130,8 @@ static inline void arch_enable_uart_fifo(void)
 #define arch_enable_uart_fifo() do { } while(0)
 #endif
 
+#define ARCH_HAVE_DECOMP_SETUP
+
 static void
 arch_decomp_setup(void)
 {
-- 
1.7.4.1
