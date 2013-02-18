From: tim.niemeyer@corscience.de (Tim Niemeyer)
Date: Mon, 18 Feb 2013 18:15:04 +0100
Subject: [PATCH] arm: update ARM_ERRATA_430973 Kconfig
Message-ID: <1361207704-11609-1-git-send-email-tim.niemeyer@corscience.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had strange problems with some illegal instructions and segmentation
faults. It turns out that the OMAP3503D (Cortex A8 r1p3) suffers from
erratum 430973.

    Discussion about this problem:
    https://bugs.launchpad.net/ubuntu/+source/fakeroot/+bug/495536
    http://www.beagleboard.org/irclogs/index.php?date=2013-02-18

Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
Signed-off-by: Thomas Weber <thomas.weber@corscience.de>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..2ca277e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1215,7 +1215,7 @@ config ARM_ERRATA_430973
 	depends on CPU_V7
 	help
 	  This option enables the workaround for the 430973 Cortex-A8
-	  (r1p0..r1p2) erratum. If a code sequence containing an ARM/Thumb
+	  (r1p*) erratum. If a code sequence containing an ARM/Thumb
 	  interworking branch is replaced with another code sequence at the
 	  same virtual address, whether due to self-modifying code or virtual
 	  to physical address re-mapping, Cortex-A8 does not recover from the
-- 
1.7.2.5
