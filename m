From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 00:43:27 +0200
Subject: [PATCH 4/5] ARM: mvebu: Enable SCU Speculative linefills to L2 for
 Armada 375/38x
In-Reply-To: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403822608-31158-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

For Armada 375 and Armada 38x SoCs, enable the SCU Speculative
linefills.

This feature may improve overall system performance.

[Gregory: modify the title of the patch and no more copy the defintion
of the bit here]

[Gregory: use the new function scu_spec_linefills_enable instead of
implementing SCU specific feature at board level]

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 8bb742fdf5ca..a24ea105e709 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -45,6 +45,7 @@ static void __init mvebu_scu_enable(void)
 		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 	if (np) {
 		scu_base = of_iomap(np, 0);
+		scu_spec_linefills_enable(scu_base, true);
 		scu_enable(scu_base);
 		of_node_put(np);
 	}
-- 
1.8.1.2
