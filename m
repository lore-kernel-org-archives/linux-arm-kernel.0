From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Mon, 13 May 2013 12:22:53 -0300
Subject: [PATCH] ARM: mvebu: Add a ranges entry to translate devbus childs
Message-ID: <1368458573-18043-1-git-send-email-elezegarcia@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

With the latest device tree reorganization which introduced the
'internal-reg' node, now the only region translated is the internal register's.
This makes the description of the hardware incomplete, for it lacks the
Device Bus childs address space.

In order to fix this, it's required to add a 'ranges' entry with a suitable
address space to map Device Bus childs, on a per-board basis.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Applies on v3.10-rc1. This is meant for v3.10.

 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index f14d36c..46b7850 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,6 +27,9 @@
 	};
 
 	soc {
+		ranges = <0          0 0xd0000000 0x100000
+			  0xf0000000 0 0xf0000000 0x8000000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
-- 
1.8.1.5
