From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 01 Nov 2010 18:00:03 +0100
Subject: [PATCH] mach-pcm037_eet: Fix section mismatch for eet_init_devices()
Message-ID: <1288630803.4156.3.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function should be marked as __init because it is used only
in the init phase.

This fix the compiler warning:
 LD      arch/arm/mach-mx3/built-in.o
 WARNING: arch/arm/mach-mx3/built-in.o(.text+0x1328): Section mismatch in reference from the function eet_init_devices() to the (unknown reference) .init.rodata:(unknown)
 The function eet_init_devices() references
 the (unknown reference) __initconst (unknown).
 This is often because eet_init_devices lacks a __initconst
 annotation or the annotation of (unknown) is wrong.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 arch/arm/mach-mx3/mach-pcm037_eet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-pcm037_eet.c b/arch/arm/mach-mx3/mach-pcm037_eet.c
index 99e0894..3392812 100644
--- a/arch/arm/mach-mx3/mach-pcm037_eet.c
+++ b/arch/arm/mach-mx3/mach-pcm037_eet.c
@@ -171,7 +171,7 @@ static struct platform_device pcm037_gpio_keys_device = {
 	},
 };
 
-static int eet_init_devices(void)
+static int __init eet_init_devices(void)
 {
 	if (!machine_is_pcm037() || pcm037_variant() != PCM037_EET)
 		return 0;
-- 
1.6.3.3
