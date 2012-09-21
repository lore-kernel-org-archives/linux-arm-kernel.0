From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 22:04:00 -0700
Subject: [PATCH] ARM: dtb: move all dtb targets to common Makefile
Message-ID: <1348203840-23559-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the dtb targets have moved to arch/arm/boot/dts/Makefile, sweep
the platforms that have had new targets added recently and move them over.

While I was at it, I also made the dtb generation more generic, i.e. if
the platform is enabled then all dtbs for that platform will be created.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: David Brown <davidb@codeaurora.com>
Cc: Barry Song <Baohua.Song@csr.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---

Already applied to next/multiplatform.

 arch/arm/boot/dts/Makefile           | 16 ++++++++++++++++
 arch/arm/mach-msm/Makefile.boot      |  3 ---
 arch/arm/mach-omap2/Makefile.boot    |  6 ------
 arch/arm/mach-prima2/Makefile.boot   |  2 --
 arch/arm/mach-shmobile/Makefile.boot |  4 ----
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d081e6a..6241732 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -16,6 +16,7 @@ dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb \
 	usb_a9260.dtb \
 	usb_a9263.dtb \
 	usb_a9g20.dtb
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos4210-smdkv310.dtb \
 	exynos5250-smdk5250.dtb
@@ -31,6 +32,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-lsxhl.dtb \
 	kirkwood-ts219-6281.dtb \
 	kirkwood-ts219-6282.dtb
+dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
+	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-db.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
@@ -49,7 +52,20 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-evk.dtb \
 	imx28-m28evk.dtb \
 	imx28-tx28.dtb
+dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
+	omap3-beagle-xm.dtb \
+	omap3-evm.dtb \
+	omap3-tobi.dtb \
+	omap4-panda.dtb \
+	omap4-pandaES.dtb \
+	omap4-var_som.dtb \
+	omap4-sdp.dtb \
+	omap5-evm.dtb
+dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
+	r8a7740-armadillo800eva.dtb \
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
diff --git a/arch/arm/mach-msm/Makefile.boot b/arch/arm/mach-msm/Makefile.boot
index f7d6ae9..9b803a5 100644
--- a/arch/arm/mach-msm/Makefile.boot
+++ b/arch/arm/mach-msm/Makefile.boot
@@ -1,6 +1,3 @@
   zreladdr-y		+= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
-
-dtb-$(CONFIG_ARCH_MSM8X60) += msm8660-surf.dtb
-dtb-$(CONFIG_ARCH_MSM8960) += msm8960-cdp.dtb
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index be0fe92..b03e562 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,9 +1,3 @@
   zreladdr-y		+= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
-
-dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
-dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle-xm.dtb omap3-evm.dtb omap3-tobi.dtb
-dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
-dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
-dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
index 98167da..c77a488 100644
--- a/arch/arm/mach-prima2/Makefile.boot
+++ b/arch/arm/mach-prima2/Makefile.boot
@@ -1,5 +1,3 @@
 zreladdr-y		+= 0x00008000
 params_phys-y		:= 0x00000100
 initrd_phys-y		:= 0x00800000
-
-dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 5e41019..498efd9 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -7,7 +7,3 @@ __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
 #
 #params_phys-y (Instead: Pass atags pointer in r2)
 #initrd_phys-y (Instead: Use compiled-in initramfs)
-
-dtb-$(CONFIG_MACH_KZM9G) += sh73a0-kzm9g.dtb
-dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dtb
-dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dtb
-- 
1.7.10.1.488.g05fbf7a
