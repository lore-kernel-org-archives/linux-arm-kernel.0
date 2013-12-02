From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:32 +0900
Subject: [PATCH 26/28] ARM: shmobile: r8a7790: care EXTAL divider settings
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <a13ba65e1e082032d3953dd249f576d64d153665.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

EXTAL clock frequency needs 1/2 when
(MD14, MD13, MD19) = (1, x, x).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 33e80b10..ecec746 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -329,10 +329,10 @@ void __init r8a7790_clock_init(void)
 		R8A7790_CLOCK_ROOT(20, &extal_clk, 130, 156, 80, 66);
 		break;
 	case MD(14):
-		R8A7790_CLOCK_ROOT(26, &extal_div2_clk, 200, 240, 122, 102);
+		R8A7790_CLOCK_ROOT(26 / 2, &extal_div2_clk, 200, 240, 122, 102);
 		break;
 	case MD(13) | MD(14):
-		R8A7790_CLOCK_ROOT(30, &extal_div2_clk, 172, 208, 106, 88);
+		R8A7790_CLOCK_ROOT(30 / 2, &extal_div2_clk, 172, 208, 106, 88);
 		break;
 	}
 
-- 
1.8.4
