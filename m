From: panchaxari.prasannamurthy@linaro.org (panchaxari)
Date: Tue, 19 Nov 2013 14:11:51 +0530
Subject: [PATCH V2] ARM:clps711x:Enable ARM_PATCH_PHYS_VIRT by default
In-Reply-To: <1384339848-8153-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
References: <1384339848-8153-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
Message-ID: <1384850511-8227-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_PATCH_PHYS_VIRT is enabled by default for clps711x systems

Introduction of this config as default will enable phy-to-virt and
virt-to-phy translation function at boot and module loading time
and enforce dynamic reallocation of memory.

This config is mutually exclusive to XIP_KERNEL, which is used in
systems with NOR flash devices

Requesting platform maintainers to evaluate  the changes on the
board and comment on the changes, as I dont have the board for
testing.

Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Alexander Shiyan <shc_work@mail.ru>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel at lists.infradead.org

V1->V2
	Re-orderd the config according to alphabetical sorting order.
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..1b5a182 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -371,6 +371,7 @@ config ARCH_AT91
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select ARCH_REQUIRE_GPIOLIB
+	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-- 
1.7.10.4
