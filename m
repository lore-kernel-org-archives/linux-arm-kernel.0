From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 18:43:37 +0800
Subject: [PATCH RESEND] arm: dts: berlin2q-marvell-dmp: remove broken-cd from
 eMMC node
Message-ID: <1447670617-7778-1-git-send-email-jszhang@marvell.com>
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
index da28c97..cdcf89b 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -94,7 +94,6 @@
 };
 
 &sdhci2 {
-	broken-cd;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-- 
2.6.2
