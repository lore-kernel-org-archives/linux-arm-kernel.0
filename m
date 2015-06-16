From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jun 2015 09:58:40 +0200
Subject: [PATCH 1/2] ARM: ep93xx: enable all boards in the EP93xx defconfig
Message-ID: <1434441520-18607-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With PATCH_PHYS_TO_VIRT we can support all EP93xx variants
in a single image, so enable all board variants in the defconfig
for simplicity and build coverage.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm a bit uncertain as this disables the NWFP(E) floating point
emulation - as we are compiling with EABI for ARMv4T on ARM920T
for all EP93xx variants I assume the compiler will handle floating
point emulation, but maybe there are some userspaces using FP
that I'm not aware of? Suggestions here would be welcome. This
makes sense as a default for me.
---
 arch/arm/configs/ep93xx_defconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index f3adf59fa315..7838cb8919e6 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -17,19 +17,25 @@ CONFIG_CRUNCH=y
 CONFIG_MACH_ADSSPHERE=y
 CONFIG_MACH_EDB9301=y
 CONFIG_MACH_EDB9302=y
+CONFIG_MACH_EDB9302A=y
 CONFIG_MACH_EDB9307=y
+CONFIG_MACH_EDB9307A=y
 CONFIG_MACH_EDB9312=y
 CONFIG_MACH_EDB9315=y
+CONFIG_MACH_EDB9315A=y
 CONFIG_MACH_GESBC9312=y
 CONFIG_MACH_MICRO9H=y
+CONFIG_MACH_MICRO9M=y
 CONFIG_MACH_MICRO9L=y
+CONFIG_MACH_MICRO9S=y
+CONFIG_MACH_SIM_ONE=y
+CONFIG_MACH_SNAPPER_CL15=y
 CONFIG_MACH_TS72XX=y
+CONFIG_MACH_VISION_EP9307=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=ttyAM0,115200 root=/dev/nfs ip=bootp"
-CONFIG_FPE_NWFPE=y
-CONFIG_FPE_NWFPE_XP=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.9.3
