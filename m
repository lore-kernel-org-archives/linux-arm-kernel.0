From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:58 +0900
Subject: [PATCH 2/2] ARM: shmobile: timer: Drop support for Cortex A8
In-Reply-To: <cover.1459732456.git.horms+renesas@verge.net.au>
References: <cover.1459732456.git.horms+renesas@verge.net.au>
Message-ID: <cd89841fc6dbb6dc11aa113769f39dcd30be720f.1459732456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy
file") removed the DTS for the last shmobile SoC with a Cortex A8 CPU
core (sh7372 aka SH-Mobile AP4).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 67d79f9c6bad..1fc7759feab1 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -54,9 +54,7 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a8")) {
-			div = 2;
-		} else if (of_device_is_compatible(np, "arm,cortex-a9")) {
+		if (of_device_is_compatible(np, "arm,cortex-a9")) {
 			div = 1;
 		} else if (of_device_is_compatible(np, "arm,cortex-a7") ||
 			 of_device_is_compatible(np, "arm,cortex-a15")) {
-- 
2.1.4
