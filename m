From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 21:55:37 +0900
Subject: [GIT PULL] fix to use static declarations for samsung stuff
Message-ID: <013b01cce7f3$48c87e30$da597a90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Arnd and Olof,

Please pull following branch which is including fix to use static
declarations for samsung stuff.
 git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-use-static

I'm not sure it can be sent to upstream for v3.3 but if so, would be better.

As a note, conflicts have been occurred when merge
arm-soc/depends/rmk/for-armsoc.
Following is my preferred resolution.

If any problems, please kindly let me know.

diff --cc arch/arm/mach-exynos/dma.c
index 8dec3db,91370de..0000000
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@@ -74,23 -74,10 +74,10 @@@ static struct dma_pl330_platdata exynos
  	.peri_id = pdma0_peri,
  };
  
- static struct amba_device exynos4_device_pdma0 = {
- 	.dev = {
- 		.init_name = "dma-pl330.0",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &exynos4_pdma0_pdata,
- 	},
- 	.res = {
- 		.start = EXYNOS4_PA_PDMA0,
- 		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA0, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
EXYNOS4_PA_PDMA0,
 -	{IRQ_PDMA0}, &exynos4_pdma0_pdata);
++static AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
++	EXYNOS4_PA_PDMA0, {IRQ_PDMA0}, &exynos4_pdma0_pdata);
  
 -u8 pdma1_peri[] = {
 +static u8 pdma1_peri[] = {
  	DMACH_PCM0_RX,
  	DMACH_PCM0_TX,
  	DMACH_PCM1_RX,
@@@ -123,21 -110,8 +110,8 @@@ static struct dma_pl330_platdata exynos
  	.peri_id = pdma1_peri,
  };
  
- static struct amba_device exynos4_device_pdma1 = {
- 	.dev = {
- 		.init_name = "dma-pl330.1",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &exynos4_pdma1_pdata,
- 	},
- 	.res = {
- 		.start = EXYNOS4_PA_PDMA1,
- 		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA1, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
EXYNOS4_PA_PDMA1,
 -	{IRQ_PDMA1}, &exynos4_pdma1_pdata);
++static AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
++	EXYNOS4_PA_PDMA1, {IRQ_PDMA1}, &exynos4_pdma1_pdata);
  
  static int __init exynos4_dma_init(void)
  {
diff --cc arch/arm/mach-s5p64x0/dma.c
index 8fce1161,f7f68ad..0000000
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@@ -108,20 -108,8 +108,8 @@@ static struct dma_pl330_platdata s5p645
  	.peri_id = s5p6450_pdma_peri,
  };
  
- static struct amba_device s5p64x0_device_pdma = {
- 	.dev = {
- 		.init_name = "dma-pl330",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 	},
- 	.res = {
- 		.start = S5P64X0_PA_PDMA,
- 		.end = S5P64X0_PA_PDMA + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_DMA0, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(s5p64x0_pdma, "dma-pl330", 0x00041330, S5P64X0_PA_PDMA,
 -	{IRQ_DMA0}, NULL);
++static AMBA_AHB_DEVICE(s5p64x0_pdma, "dma-pl330", 0x00041330,
++	S5P64X0_PA_PDMA, {IRQ_DMA0}, NULL);
  
  static int __init s5p64x0_dma_init(void)
  {
diff --cc arch/arm/mach-s5pc100/dma.c
index 395e46b,96b1ab3..0000000
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@@ -73,23 -73,10 +73,10 @@@ static struct dma_pl330_platdata s5pc10
  	.peri_id = pdma0_peri,
  };
  
- static struct amba_device s5pc100_device_pdma0 = {
- 	.dev = {
- 		.init_name = "dma-pl330.0",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &s5pc100_pdma0_pdata,
- 	},
- 	.res = {
- 		.start = S5PC100_PA_PDMA0,
- 		.end = S5PC100_PA_PDMA0 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA0, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(s5pc100_pdma0,  "dma-pl330.0", 0x00041330,
S5PC100_PA_PDMA0,
 -	{IRQ_PDMA0}, &s5pc100_pdma0_pdata);
++static AMBA_AHB_DEVICE(s5pc100_pdma0,  "dma-pl330.0", 0x00041330,
++	S5PC100_PA_PDMA0, {IRQ_PDMA0}, &s5pc100_pdma0_pdata);
  
 -u8 pdma1_peri[] = {
 +static u8 pdma1_peri[] = {
  	DMACH_UART0_RX,
  	DMACH_UART0_TX,
  	DMACH_UART1_RX,
@@@ -127,21 -114,8 +114,8 @@@ static struct dma_pl330_platdata s5pc10
  	.peri_id = pdma1_peri,
  };
  
- static struct amba_device s5pc100_device_pdma1 = {
- 	.dev = {
- 		.init_name = "dma-pl330.1",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &s5pc100_pdma1_pdata,
- 	},
- 	.res = {
- 		.start = S5PC100_PA_PDMA1,
- 		.end = S5PC100_PA_PDMA1 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA1, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(s5pc100_pdma1, "dma-pl330.1", 0x00041330,
S5PC100_PA_PDMA1,
 -	{IRQ_PDMA1}, &s5pc100_pdma1_pdata);
++static AMBA_AHB_DEVICE(s5pc100_pdma1, "dma-pl330.1", 0x00041330,
++	S5PC100_PA_PDMA1, {IRQ_PDMA1}, &s5pc100_pdma1_pdata);
  
  static int __init s5pc100_dma_init(void)
  {
diff --cc arch/arm/mach-s5pv210/dma.c
index fc1be6e,f6885d2..0000000
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@@ -71,23 -71,10 +71,10 @@@ static struct dma_pl330_platdata s5pv21
  	.peri_id = pdma0_peri,
  };
  
- static struct amba_device s5pv210_device_pdma0 = {
- 	.dev = {
- 		.init_name = "dma-pl330.0",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &s5pv210_pdma0_pdata,
- 	},
- 	.res = {
- 		.start = S5PV210_PA_PDMA0,
- 		.end = S5PV210_PA_PDMA0 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA0, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(s5pv210_pdma0, "dma-pl330.0", 0x00041330,
S5PV210_PA_PDMA0,
 -	{IRQ_PDMA0}, &s5pv210_pdma0_pdata);
++static AMBA_AHB_DEVICE(s5pv210_pdma0, "dma-pl330.0", 0x00041330,
++	S5PV210_PA_PDMA0, {IRQ_PDMA0}, &s5pv210_pdma0_pdata);
  
 -u8 pdma1_peri[] = {
 +static u8 pdma1_peri[] = {
  	DMACH_UART0_RX,
  	DMACH_UART0_TX,
  	DMACH_UART1_RX,
@@@ -127,21 -114,8 +114,8 @@@ static struct dma_pl330_platdata s5pv21
  	.peri_id = pdma1_peri,
  };
  
- static struct amba_device s5pv210_device_pdma1 = {
- 	.dev = {
- 		.init_name = "dma-pl330.1",
- 		.dma_mask = &dma_dmamask,
- 		.coherent_dma_mask = DMA_BIT_MASK(32),
- 		.platform_data = &s5pv210_pdma1_pdata,
- 	},
- 	.res = {
- 		.start = S5PV210_PA_PDMA1,
- 		.end = S5PV210_PA_PDMA1 + SZ_4K,
- 		.flags = IORESOURCE_MEM,
- 	},
- 	.irq = {IRQ_PDMA1, NO_IRQ},
- 	.periphid = 0x00041330,
- };
 -AMBA_AHB_DEVICE(s5pv210_pdma1, "dma-pl330.1", 0x00041330,
S5PV210_PA_PDMA1,
 -	{IRQ_PDMA1}, &s5pv210_pdma1_pdata);
++static AMBA_AHB_DEVICE(s5pv210_pdma1, "dma-pl330.1", 0x00041330,
++	S5PV210_PA_PDMA1, {IRQ_PDMA1}, &s5pv210_pdma1_pdata);
  
  static int __init s5pv210_dma_init(void)
  {

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/cleanup-use-static

Kukjin Kim (7):
      ARM: EXYNOS: use static declaration when it is not used in other files
      ARM: S3C24XX: use static declaration when it is not used in other
files
      ARM: S3C64XX: use static declaration when it is not used in other
files
      ARM: S5P64X0: use static declaration when it is not used in other
files
      ARM: S5PC100: use static declaration when it is not used in other
files
      ARM: S5PV210: use static declaration when it is not used in other
files
      ARM: SAMSUNG: use static declaration when it is not used in other
files

 arch/arm/mach-exynos/clock-exynos4210.c            |    2 +-
 arch/arm/mach-exynos/clock-exynos4212.c            |    2 +-
 arch/arm/mach-exynos/clock.c                       |    2 +-
 arch/arm/mach-exynos/common.c                      |    2 +-
 arch/arm/mach-exynos/dma.c                         |   12 ++++----
 arch/arm/mach-exynos/mach-origen.c                 |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c         |    2 +-
 arch/arm/mach-s3c2410/mach-h1940.c                 |   12 ++++----
 arch/arm/mach-s3c2416/clock.c                      |    6 ----
 arch/arm/mach-s3c2416/mach-smdk2416.c              |    8 +++---
 arch/arm/mach-s3c2440/mach-gta02.c                 |    4 +-
 arch/arm/mach-s3c2440/mach-rx1950.c                |   12 ++++----
 arch/arm/mach-s3c64xx/common.c                     |    2 +-
 arch/arm/mach-s3c64xx/common.h                     |    2 -
 arch/arm/mach-s3c64xx/irq-pm.c                     |    2 +-
 arch/arm/mach-s5p64x0/clock.c                      |   11 ++++---
 arch/arm/mach-s5p64x0/dma.c                        |   10 +++---
 arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h |    7 -----
 arch/arm/mach-s5pc100/clock.c                      |   28
++++++++++----------
 arch/arm/mach-s5pc100/dma.c                        |   12 ++++----
 arch/arm/mach-s5pv210/dma.c                        |   12 ++++----
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +-
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |    2 +-
 arch/arm/plat-s5p/irq-eint.c                       |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c                    |    2 +-
 arch/arm/plat-samsung/devs.c                       |   13 +--------
 arch/arm/plat-samsung/dma-ops.c                    |    2 +-
 28 files changed, 76 insertions(+), 101 deletions(-)
