From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Aug 2010 01:18:43 -0500
Subject: [PATCH] arm: tegra: fix compilation of board-harmony.c
Message-ID: <20100818061843.GA32043@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "ARM: Remove DISCONTIGMEM support" removed the node id from
the meminfo struct and the PHYS_TO_NID macro, causing compilation errors:

arch/arm/mach-tegra/board-harmony.c: In function 'tegra_harmony_fixup':
arch/arm/mach-tegra/board-harmony.c:94: error: 'struct membank' has no member named 'node'
arch/arm/mach-tegra/board-harmony.c:94: error: implicit declaration of function 'PHYS_TO_NID'
arch/arm/mach-tegra/board-harmony.c:97: error: 'struct membank' has no member named 'node'

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/board-harmony.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 05e78dd..9e305de 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -91,10 +91,8 @@ static void __init tegra_harmony_fixup(struct machine_desc *desc,
 {
 	mi->nr_banks = 2;
 	mi->bank[0].start = PHYS_OFFSET;
-	mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
 	mi->bank[0].size = 448 * SZ_1M;
 	mi->bank[1].start = SZ_512M;
-	mi->bank[1].node = PHYS_TO_NID(SZ_512M);
 	mi->bank[1].size = SZ_512M;
 }
 
-- 
1.5.6.5
