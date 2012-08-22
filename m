From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 Aug 2012 10:22:30 +0200
Subject: [PATCH v2 9/9] ARM: mvebu: adjust Armada XP evaluation board DTS
In-Reply-To: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1345623750-10645-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The Armada XP evaluation board is based on the MV78460 Armava XP
SoC. Now that we have separate .dtsi files for the three different
SoCs of the Armada XP family, use the appropriate one as include for
the Armada XP evaluation board .dts file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/armada-xp-db.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index f97040d..b1fc728 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -14,11 +14,11 @@
  */
 
 /dts-v1/;
-/include/ "armada-xp.dtsi"
+/include/ "armada-xp-mv78460.dtsi"
 
 / {
 	model = "Marvell Armada XP Evaluation Board";
-	compatible = "marvell,axp-db", "marvell,armadaxp", "marvell,armada-370-xp";
+	compatible = "marvell,axp-db", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
 
 	chosen {
 		bootargs = "console=ttyS0,115200 earlyprintk";
-- 
1.7.10.4
