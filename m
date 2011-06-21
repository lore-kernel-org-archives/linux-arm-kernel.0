From: leiwen@marvell.com (Lei Wen)
Date: Tue, 21 Jun 2011 02:54:19 -0700
Subject: [PATCH 2/2] ARM: pxa168: correct nand pmu setting
In-Reply-To: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
References: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
Message-ID: <1308650059-27226-2-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original pair of <0x01db, 208000000> is invalid.
Correct to the valid value.

Signed-off-by: Lei Wen <leiwen@marvell.com>
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
1.7.0.4
