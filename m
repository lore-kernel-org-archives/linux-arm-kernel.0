From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 17 May 2013 08:09:57 -0300
Subject: [PATCH 1/2] ARM: mvebu: Fix ranges entry on XP GP board
Message-ID: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the latest device tree reorganization which introduced the
'internal-reg' node, now the only region translated is the internal register's.
This makes the description of the hardware incomplete, for it lacks the
Device Bus childs address space.

In order to fix this, it's required to add a 'ranges' entry with a suitable
address space to map Device Bus childs, on a per-board basis.
This patch fixes the ranges property on the Armada XP GP board.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This should be included in v3.10.

 arch/arm/boot/dts/armada-xp-gp.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 26ad06f..3ee63d1 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,6 +39,9 @@
 	};
 
 	soc {
+		ranges = <0          0 0xd0000000 0x100000
+			  0xf0000000 0 0xf0000000 0x1000000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
-- 
1.8.1.5
