From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 14:22:40 +0800
Subject: [PATCH] arm: dts: berlin2q-marvell-dmp: remove broken-cd from eMMC
 node
Message-ID: <1445235760-2062-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The eMMC is non-removable so is marked with the non-removable DT
property to avoid having to redetect it after a suspend/resume.

But it also has the broken-cd property which is wrong since only
one of the DT properties for card detection should be used

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 4a749e5..0fa8f1e 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -93,7 +93,6 @@
 };
 
 &sdhci2 {
-	broken-cd;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.6.1
