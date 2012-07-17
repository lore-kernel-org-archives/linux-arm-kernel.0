From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 13:59:20 +0200
Subject: [PATCH] arm: mvebu: generate DTBs for supported SoCs
Message-ID: <1342526360-8417-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary dtb-$(CONFIG_...) entries so that "make dtbs"
generates the Device Tree Blobs that correspond to the selected mvebu
SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Makefile.boot |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/Makefile.boot b/arch/arm/mach-mvebu/Makefile.boot
index b327175..2579a2f 100644
--- a/arch/arm/mach-mvebu/Makefile.boot
+++ b/arch/arm/mach-mvebu/Makefile.boot
@@ -1 +1,3 @@
 zreladdr-y := 0x00008000
+dtb-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-db.dtb
+dtb-$(CONFIG_MACH_ARMADA_370_XP) += armada-xp-db.dtb
-- 
1.7.9.5
