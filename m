From: stefan@agner.ch (Stefan Agner)
Date: Thu,  9 Apr 2015 22:04:11 +0200
Subject: [PATCH v5 07/11] ARM: introduce ARM_SINGLE_ARMV7M for ARMv7-M
 platforms
In-Reply-To: <1428609855-27657-1-git-send-email-stefan@agner.ch>
References: <1428609855-27657-1-git-send-email-stefan@agner.ch>
Message-ID: <1428609855-27657-8-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a new top level config symbol ARM_SINGLE_ARMV7M
for non-MMU, ARMv7-M platforms. It also support multiple ARMv7-M
platforms in one kernel image since the cores share the same
basic memory layout and interrupt controller. However, this works
only if the combined platforms also have a similar (main) memory
layout.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..66e60af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -323,6 +323,19 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SINGLE_ARMV7M
+	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
+	depends on !MMU
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_NVIC
+	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_V7M
+	select GENERIC_CLOCKEVENTS
+	select NO_IOPORT_MAP
+	select SPARSE_IRQ
+	select USE_OF
+
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-- 
2.3.5
