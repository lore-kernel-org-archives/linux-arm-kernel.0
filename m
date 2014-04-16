From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Apr 2014 09:46:34 +0200
Subject: [PATCH v2 1/2] ARM: berlin: add the LIBGPIO as a dependency for the
 BG2Q
In-Reply-To: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1397634395-7456-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1397634395-7456-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BG2Q has GPIOs driven by the dwapb GPIO driver. Add the LIBGPIO as a
dependency to be able to support them.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 291f1cac6c3d..150fda8fe110 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_BERLIN
 	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select DW_APB_ICTL
-- 
1.8.3.2
