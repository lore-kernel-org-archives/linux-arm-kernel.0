From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed,  6 Jul 2011 23:52:29 +0800
Subject: [PATCH 3/3] ARM: pxa168: correct nand pmu setting
In-Reply-To: <1309967549-3394-1-git-send-email-eric.y.miao@gmail.com>
References: <1309967549-3394-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1309967549-3394-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lei Wen <leiwen@marvell.com>

The original pair of <0x01db, 208000000> is invalid. Correct it to
the valid value.

The 6th bit of the NFC APMU register indicates NFC works whether
at 156Mhz or 78Mhz. So 0x19b indicates NFC works at 156Mhz, and
0x1db indicates it works at 78Mhz.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Cc: stable at kernel.org
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/pxa168.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..ab9f999 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,7 +79,7 @@ static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
 static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
 
-static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 
 /* device and clock bindings */
-- 
1.7.4.1
