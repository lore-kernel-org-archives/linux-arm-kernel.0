From: panchaxari.prasannamurthy@linaro.org (panchaxari)
Date: Thu,  9 Jan 2014 11:49:42 +0530
Subject: [PATCH CFT] ARM:VERSATILE: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
Message-ID: <1389248382-5262-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR as default configs
to versatile platform.

Introduction of PHYS_VIRT config as default enables phy-to-virt and virt-to-phy
translation functions at boot and module loading time, and enforce dynamic
reallocation of memory. PHYS_VIRT config is mutually exclusive to XIP_KERNEL,
XIP_KERNEL is used in systems with NOR flash devices.

AUTO_ZRELADDR config enables auto calculation of the decompressed kernel image
address. AUTO_ZRELADDR config is mutually exclusive to ZBOOT_ROM, and also
assumes zImage to be loaded in the first 128MiB from start of memory.

CFT::Call For Testing

Requesting maintainers of Versatile platform to evaluate the changes on the
board and comment, as I dont have the board for testing and also requesting
an ACK.

Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Pawel Moll <Pawel.Moll@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7f316c0..077ef9d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -348,8 +348,10 @@ config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
 	select ARM_TIMER_SP804
 	select ARM_VIC
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_MACH_CLKDEV
-- 
1.7.10.4
