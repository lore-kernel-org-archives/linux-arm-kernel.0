From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 13 Apr 2017 13:18:58 +0100
Subject: [PATCH 2/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 comments etc.
In-Reply-To: <20170404092604.GB14898@arm.com>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org> <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org> <20170404092604.GB14898@arm.com>
Message-ID: <1492085938.20068.6.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Less important than in user-visible messages, but still good practice as
there's still no excuse for ARM64 code to look like it was written before
1996.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  2 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |  2 +-
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts           | 24 +++++++++++-----------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts      |  2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts      |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  2 +-
 arch/arm64/include/asm/assembler.h                 |  2 +-
 arch/arm64/include/asm/boot.h                      |  4 ++--
 arch/arm64/include/asm/elf.h                       |  2 +-
 arch/arm64/include/asm/fixmap.h                    |  6 +++---
 arch/arm64/kernel/head.S                           |  8 ++++----
 arch/arm64/kernel/hyp-stub.S                       |  2 +-
 arch/arm64/kernel/kaslr.c                          | 14 ++++++-------
 arch/arm64/kernel/module-plts.c                    |  2 +-
 arch/arm64/kernel/vmlinux.lds.S                    | 18 ++++++++--------
 arch/arm64/mm/mmu.c                                |  2 +-
 arch/arm64/mm/proc.S                               |  2 +-
 22 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index df539e8..f70fb13 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -694,7 +694,7 @@
 
 	memory at 80000000 {
 		device_type = "memory";
-		/* last 16MB of the first memory area is reserved for secure world use by firmware */
+		/* last 16MiB of the first memory area is reserved for secure world use by firmware */
 		reg = <0x00000000 0x80000000 0x0 0x7f000000>,
 		      <0x00000008 0x80000000 0x1 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index e3a1711..38ece4b 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -60,7 +60,7 @@
 
 	memory at 80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0x80000000>; /* 2GB @ 2GB */
+		reg = <0 0x80000000 0 0x80000000>; /* 2GiB @ 2GiB */
 	};
 
 	gic: interrupt-controller at 2c001000 {
diff --git a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
index 99a2723..5908524 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
@@ -87,36 +87,36 @@
 
 		partition at 0 {
 			label = "nboot";
-			reg = <0x00000000 0x00280000>; /*  2.5MB */
+			reg = <0x00000000 0x00280000>; /*  2.5MiB */
 			read-only;
 		};
 
 		partition at 280000 {
 			label = "nenv";
-			reg = <0x00280000 0x00040000>; /* 0.25MB */
+			reg = <0x00280000 0x00040000>; /* 0.25MiB */
 			read-only;
 		};
 
 		partition at 2c0000 {
 			label = "ndtb";
-			reg = <0x002c0000 0x00040000>; /* 0.25MB */
+			reg = <0x002c0000 0x00040000>; /* 0.25MiB */
 			read-only;
 		};
 
 		partition at 300000 {
 			label = "nsystem";
-			reg = <0x00300000 0x03d00000>; /*   61MB */
+			reg = <0x00300000 0x03d00000>; /*   61MiB */
 			read-only;
 		};
 
 		partition at 4000000 {
 			label = "nrootfs";
-			reg = <0x04000000 0x06400000>; /*  100MB */
+			reg = <0x04000000 0x06400000>; /*  100MiB */
 		};
 
 		partition at 0a400000{
 			label = "ncustfs";
-			reg = <0x0a400000 0x35c00000>; /*  860MB */
+			reg = <0x0a400000 0x35c00000>; /*  860MiB */
 		};
 	};
 };
@@ -156,32 +156,32 @@
 
 		partition at 0 {
 			label = "bl0";
-			reg = <0x00000000 0x00080000>; /*  512KB */
+			reg = <0x00000000 0x00080000>; /*  512KiB */
 		};
 
 		partition at 80000 {
 			label = "fip";
-			reg = <0x00080000 0x00150000>; /* 1344KB */
+			reg = <0x00080000 0x00150000>; /* 1344KiB */
 		};
 
 		partition at 1e0000 {
 			label = "env";
-			reg = <0x001e0000 0x00010000>;/*    64KB */
+			reg = <0x001e0000 0x00010000>;/*    64KiB */
 		};
 
 		partition at 1f0000 {
 			label = "dtb";
-			reg = <0x001f0000 0x00010000>; /*   64KB */
+			reg = <0x001f0000 0x00010000>; /*   64KiB */
 		};
 
 		partition at 200000 {
 			label = "kernel";
-			reg = <0x00200000 0x00e00000>; /*   14MB */
+			reg = <0x00200000 0x00e00000>; /*   14MiB */
 		};
 
 		partition at 1000000 {
 			label = "rootfs";
-			reg = <0x01000000 0x01000000>; /*   16MB */
+			reg = <0x01000000 0x01000000>; /*   16MiB */
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index c37110b..71ce1f1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -126,7 +126,7 @@
 	flash at 0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
+		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MiB */
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index e5935f2..43e549f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -152,7 +152,7 @@
 	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x80000000>;
-		      /* DRAM space - 1, size : 2 GB DRAM */
+		      /* DRAM space - 1, size : 2 GiB DRAM */
 	};
 
 	sysclk: sysclk {
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
index fae6c69..4b3a5e2 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
@@ -56,7 +56,7 @@
 
 	memory at 1000000 {
 		device_type = "memory";
-		/* the first 16MB is for firmwares' usage */
+		/* the first 16MiB is for firmwares' usage */
 		reg = <0 0x01000000 0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
index d47edad..049018b 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
@@ -56,7 +56,7 @@
 
 	memory at 1000000 {
 		device_type = "memory";
-		/* the first 16MB is for firmwares' usage */
+		/* the first 16MiB is for firmwares' usage */
 		reg = <0 0x01000000 0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index c5f8f69..15f57e6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -29,7 +29,7 @@
 
 	memory at 48000000 {
 		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 7a8986e..35f7cd2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -52,7 +52,7 @@
 
 	memory at 48000000 {
 		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index c3f064a..4d1295e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -28,7 +28,7 @@
 
 	memory at 48000000 {
 		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c7f40f8..2a019a3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -28,7 +28,7 @@
 
 	memory at 48000000 {
 		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 1b67c37..56094e2 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -165,7 +165,7 @@ lr	.req	x30		// link register
 
 /*
  * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
- * <symbol> is within the range +/- 4 GB of the PC when running
+ * <symbol> is within the range +/- 4 GiB of the PC when running
  * in core kernel context. In module context, a movz/movk sequence
  * is used, since modules may be loaded far away from the kernel
  * when KASLR is in effect.
diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index ebf2481..95e26bc 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -6,14 +6,14 @@
 
 /*
  * arm64 requires the DTB to be 8 byte aligned and
- * not exceed 2MB in size.
+ * not exceed 2MiB in size.
  */
 #define MIN_FDT_ALIGN		8
 #define MAX_FDT_SIZE		SZ_2M
 
 /*
  * arm64 requires the kernel image to placed
- * TEXT_OFFSET bytes beyond a 2 MB aligned base
+ * TEXT_OFFSET bytes beyond a 2 MiB aligned base
  */
 #define MIN_KIMG_ALIGN		SZ_2M
 
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5d17004..28e63ff 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -156,7 +156,7 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
-/* 1GB of VA */
+/* 1GiB of VA */
 #ifdef CONFIG_COMPAT
 #define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index caf86be..7e90ab2 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -37,13 +37,13 @@ enum fixed_addresses {
 	FIX_HOLE,
 
 	/*
-	 * Reserve a virtual window for the FDT that is 2 MB larger than the
+	 * Reserve a virtual window for the FDT that is 2 MiB larger than the
 	 * maximum supported size, and put it at the top of the fixmap region.
 	 * The additional space ensures that any FDT that does not exceed
 	 * MAX_FDT_SIZE can be mapped regardless of whether it crosses any
-	 * 2 MB alignment boundaries.
+	 * 2 MiB alignment boundaries.
 	 *
-	 * Keep this at the top so it remains 2 MB aligned.
+	 * Keep this at the top so it remains 2 MiB aligned.
 	 */
 #define FIX_FDT_SIZE		(MAX_FDT_SIZE + SZ_2M)
 	FIX_FDT_END,
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4fb6ccd..067ddd6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -45,11 +45,11 @@
 #define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)
 
 #if (TEXT_OFFSET & 0xfff) != 0
-#error TEXT_OFFSET must be at least 4KB aligned
+#error TEXT_OFFSET must be at least 4KiB aligned
 #elif (PAGE_OFFSET & 0x1fffff) != 0
-#error PAGE_OFFSET must be at least 2MB aligned
+#error PAGE_OFFSET must be at least 2MiB aligned
 #elif TEXT_OFFSET > 0x1fffff
-#error TEXT_OFFSET must be less than 2MB
+#error TEXT_OFFSET must be less than 2MiB
 #endif
 
 /*
@@ -360,7 +360,7 @@ ENDPROC(preserve_boot_args)
  * Setup the initial page tables. We only setup the barest amount which is
  * required to get the kernel running. The following sections are required:
  *   - identity mapping to enable the MMU (low address, TTBR0)
- *   - first few MB of the kernel linear mapping to jump to once the MMU has
+ *   - first few MiB of the kernel linear mapping to jump to once the MMU has
  *     been enabled
  */
 __create_page_tables:
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index d3b5f75..9585ea7 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -106,7 +106,7 @@ ENDPROC(\label)
  * be called on each CPU.
  *
  * x0 must be the physical address of the new vector table, and must be
- * 2KB aligned.
+ * 2KiB aligned.
  *
  * Before calling this, you must check that the stub hypervisor is installed
  * everywhere, by waiting for any secondary CPUs to be brought up and then
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index d7e90d9..a5a3068 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -118,9 +118,9 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
 	 * lower half of the VMALLOC area (VA_BITS - 2).
-	 * Even if we could randomize at page granularity for 16k and 64k pages,
-	 * let's always round to 2 MB so we don't interfere with the ability to
-	 * map using contiguous PTEs
+	 * Even if we could randomize at page granularity for 16KiB and 64KiB
+	 * pages, let's always round to 2 MiB so we don't interfere with the
+	 * ability to map using contiguous PTEs
 	 */
 	mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1);
 	offset = seed & mask;
@@ -129,10 +129,10 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_offset)
 	memstart_offset_seed = seed >> 48;
 
 	/*
-	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
-	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, increase the KASLR offset by the size of the kernel image
-	 * rounded up by SWAPPER_BLOCK_SIZE.
+	 * The kernel Image should not extend across a 1GiB/32MiB/512MiB
+	 * alignment boundary (for 4KiB/16KiB/64KiB granule kernels,
+	 * respectively). If this happens, increase the KASLR offset by
+	 * the size of the kernel image rounded up by SWAPPER_BLOCK_SIZE.
 	 */
 	if ((((u64)_text + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT) !=
 	    (((u64)_end + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT)) {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 1ce90d8..0d66734 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -118,7 +118,7 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
 			 * We only have to consider branch targets that resolve
 			 * to undefined symbols. This is not simply a heuristic,
 			 * it is a fundamental limitation, since the PLT itself
-			 * is part of the module, and needs to be within 128 MB
+			 * is part of the module, and needs to be within 128 MiB
 			 * as well, so modules can never grow beyond that limit.
 			 */
 			s = syms + ELF64_R_SYM(rela[i].r_info);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b8deffa..93b39d6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -25,12 +25,12 @@ jiffies = jiffies_64;
 
 #define HYPERVISOR_TEXT					\
 	/*						\
-	 * Align to 4 KB so that			\
+	 * Align to 4 KiB so that			\
 	 * a) the HYP vector table is at its minimum	\
 	 *    alignment of 2048 bytes			\
 	 * b) the HYP init code will not cross a page	\
 	 *    boundary if its size does not exceed	\
-	 *    4 KB (see related ASSERT() below)		\
+	 *    4 KiB (see related ASSERT() below)	\
 	 */						\
 	. = ALIGN(SZ_4K);				\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;	\
@@ -60,7 +60,7 @@ jiffies = jiffies_64;
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
  * FileAlignment, which we set to its minimum value of 0x200. 'stext'
- * itself is 4 KB aligned, so padding out _edata to a 0x200 aligned
+ * itself is 4 KiB aligned, so padding out _edata to a 0x200 aligned
  * boundary should be sufficient.
  */
 PECOFF_FILE_ALIGNMENT = 0x200;
@@ -74,16 +74,16 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 
 #if defined(CONFIG_DEBUG_ALIGN_RODATA)
 /*
- *  4 KB granule:   1 level 2 entry
- * 16 KB granule: 128 level 3 entries, with contiguous bit
- * 64 KB granule:  32 level 3 entries, with contiguous bit
+ *  4 KiB granule:   1 level 2 entry
+ * 16 KiB granule: 128 level 3 entries, with contiguous bit
+ * 64 KiB granule:  32 level 3 entries, with contiguous bit
  */
 #define SEGMENT_ALIGN			SZ_2M
 #else
 /*
- *  4 KB granule:  16 level 3 entries, with contiguous bit
- * 16 KB granule:   4 level 3 entries, without contiguous bit
- * 64 KB granule:   1 level 3 entry
+ *  4 KiB granule:  16 level 3 entries, with contiguous bit
+ * 16 KiB granule:   4 level 3 entries, without contiguous bit
+ * 64 KiB granule:   1 level 3 entry
  */
 #define SEGMENT_ALIGN			SZ_64K
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d28dbcf..5d8b743 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -229,7 +229,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 
 		/*
-		 * For 4K granule only, attempt to put down a 1GB block
+		 * For 4KiB granule only, attempt to put down a 1GiB block
 		 */
 		if (use_1G_block(addr, next, phys) && !page_mappings_only) {
 			pud_set_huge(pud, phys, prot);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..daba6ba 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -221,7 +221,7 @@ ENTRY(__cpu_setup)
 	bic	x0, x0, x5			// clear bits
 	orr	x0, x0, x6			// set bits
 	/*
-	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
+	 * Set/prepare TCR and TTBR. We use 512GiB (39-bit) address range for
 	 * both user and kernel.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
-- 
2.9.3

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170413/6fa9d272/attachment.bin>
