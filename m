From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:23:52 +0100
Subject: [PATCH 20/22] ARM: gemini: select ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR
Message-ID: <20170122122352.11060-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform survives physical to virtual patching
without any hickups, and can use AUTO_ZRELADDR.
We still need to keep Makefile.boot but it is now empty.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                   | 2 ++
 arch/arm/mach-gemini/Makefile.boot | 4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c448dc49467..2e99bf1c5c53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,6 +356,8 @@ config ARM_SINGLE_ARMV7M
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select CPU_FA526
diff --git a/arch/arm/mach-gemini/Makefile.boot b/arch/arm/mach-gemini/Makefile.boot
index 760a0efe7580..8e3d1c6e1e38 100644
--- a/arch/arm/mach-gemini/Makefile.boot
+++ b/arch/arm/mach-gemini/Makefile.boot
@@ -1,3 +1 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
+# Empty on purpose
-- 
2.9.3
