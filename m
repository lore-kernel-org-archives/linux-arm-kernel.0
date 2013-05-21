From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:26 +0200
Subject: [PATCH 1/9] arm: mvebu: fix length of SATA registers area in .dtsi
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The length of the registers area for the Marvell 370/XP SATA
controller was incorrect in the .dtsi: 0x2400 while it should have
been 0x5000. Until now, this problem wasn't noticed because there was
a large static mapping for all I/Os set up by ->map_io(). But since
we're going to get rid of this static mapping, we need to ensure that
the register areas are properly sized.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 272bbc6..75de3fe 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -79,7 +79,7 @@
 
 			sata at a0000 {
 				compatible = "marvell,orion-sata";
-				reg = <0xa0000 0x2400>;
+				reg = <0xa0000 0x5000>;
 				interrupts = <55>;
 				clocks = <&gateclk 15>, <&gateclk 30>;
 				clock-names = "0", "1";
-- 
1.7.9.5
