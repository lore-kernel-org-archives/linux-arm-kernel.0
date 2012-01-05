From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 5 Jan 2012 11:27:52 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120105112752.5bc8a1fe745dfe3adbc45fe9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-exynos/Makefile between commit cc511b8d84d8 ("ARM: 7257/1:
EXYNOS: introduce arch/arm/mach-exynos/common.[ch]") from the arm tree
and commit fca3de6ab9bf ("ARM: EXYNOS: Limit usage of pl330 device
instance to non-dt build") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/Makefile
index bcb9efc,db527ab..0000000
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@@ -19,8 -19,6 +19,8 @@@ obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-e
  obj-$(CONFIG_PM)		+= pm.o
  obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
  
- obj-$(CONFIG_ARCH_EXYNOS4)	+= dma.o pmu.o
++obj-$(CONFIG_ARCH_EXYNOS4)	+= pmu.o
 +
  obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
  
  obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
@@@ -46,8 -46,9 +48,10 @@@ obj-$(CONFIG_EXYNOS4_DEV_AHCI)		+= dev-
  obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
  obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
  obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
+ obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
+ obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
  
 +obj-$(CONFIG_ARCH_EXYNOS4)		+= setup-i2c0.o
  obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
  obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
  obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120105/daab7956/attachment.sig>
