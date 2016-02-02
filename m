From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Feb 2016 16:23:02 +0100
Subject: [PATCH 1/3] ARM: shmobile: defconfig: Do not enable
 CONFIG_CPU_BPREDICT_DISABLE
In-Reply-To: <cover.1454409855.git.horms+renesas@verge.net.au>
References: <cover.1454409855.git.horms+renesas@verge.net.au>
Message-ID: <406663ed61c8ad2b792824af1c1bc0e4faa711c6.1454409855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Do not disable branch prediction, as this has a big performance impact.

After re-enabling branch prediction, __loop_delay() runs 16 (Cortex A15)
or 11 (Cortex A9) times faster than before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 969738324a5d..5208b5caacd1 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
-- 
2.7.0.rc3.207.g0ac5344
