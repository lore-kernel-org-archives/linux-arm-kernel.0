From: panchaxari.prasannamurthy@linaro.org (panchaxari)
Date: Fri, 13 Dec 2013 10:41:06 +0530
Subject: [PATCH CFT] ARM:S5PC100: Enable ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR
 by default
Message-ID: <1386911466-19139-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR have been enabled as default configs
to S5PC100 platform

Introduction of PHYS_VIRT config as default would enable phy-to-virt and
virt-to-phy translation function at boot and module loading time
and enforce dynamic reallocation of memory. AUTO_ZRELADDR config would
enable calculation of kernel load address at run time.

PHYS_VIRT config is mutually exclusive to XIP_KERNEL, XIP_KERNEL is used in
systems with NOR flash devices, and ZRELADDR config is mutually exclusive
to ZBOOT_ROM.

CFT::Call For Testing

Requesting maintainers of S5PC100 platforms to evaluate the changes on the board
and comment, as I dont have the board for testing and also requesting an ACK.

Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8986335..ec1faea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -778,7 +778,9 @@ config ARCH_S5P64X0
 
 config ARCH_S5PC100
 	bool "Samsung S5PC100"
+	select ARM_PATCH_PHYS_VIRT
 	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
 	select CPU_V7
-- 
1.7.10.4
