From: leiwen@marvell.com (Lei Wen)
Date: Tue, 21 Jun 2011 02:54:18 -0700
Subject: [PATCH 1/2] ARM: pxa910: correct nand pmu setting
Message-ID: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original pair of <0x01db, 208000000> is invalid.
Correct to the valid value.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/pxa910.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 8f92ccd..1464607 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -110,7 +110,7 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
 
-static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(u2o, USB, 0x1b, 480000000);
 
 /* device and clock bindings */
-- 
1.7.0.4
