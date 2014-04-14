From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 17:29:19 +0200
Subject: [PATCH v2 2/4] ARM: mvebu: fix NOR bus-width in Armada XP GP Device
 Tree
In-Reply-To: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397489361-5833-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu-devbus driver had a serious bug, which lead to a 8 bits bus
width declared in the Device Tree being considered as a 16 bits bus
width when configuring the hardware.

This bug in mvebu-devbus driver was compensated by a symetric mistake
in the Armada XP GP Device Tree: a 8 bits bus width was declared, even
though the hardware actually has a 16 bits bus width connection with
the NOR flash.

Now that we have fixed the mvebu-devbus driver to behave according to
its Device Tree binding, this commit fixes the problematic Device Tree
files as well.

This bug was introduced in commit
da8d1b38356853c37116f9afa29f15648d7fb159 ('ARM: mvebu: Add support for
NOR flash device on Armada XP-GP board') which was merged in v3.10.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: stable at vger.kernel.org
---
 arch/arm/boot/dts/armada-xp-gp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 61bda68..3a359fd 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -59,7 +59,7 @@
 			/* Device Bus parameters are required */
 
 			/* Read parameters */
-			devbus,bus-width    = <8>;
+			devbus,bus-width    = <16>;
 			devbus,turn-off-ps  = <60000>;
 			devbus,badr-skew-ps = <0>;
 			devbus,acc-first-ps = <124000>;
-- 
1.8.3.2
