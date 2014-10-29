From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Oct 2014 09:40:00 -0200
Subject: [PATCH v2] ARM: l2c: Improve l2c310_of_parse() error message
Message-ID: <1414582800-26907-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Russell King suggested [1]:

"I'd ask for one change.  Please make all these messages start with
"L2C-310 OF" not "PL310 OF:".  The device is described in ARM
documentation as a L2C-310 not PL310.  (Also note the : is dropped
too - most of the other messages don't have the : either.)

The:

"PL310 OF: cache setting yield illegal associativity
PL310 OF: -1073346556 calculated, only 8 and 16 legal"

message could also be changed to something like:

"L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n" 

[1] http://www.spinics.net/lists/arm-kernel/msg372776.html

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Make checkpatch happy

 arch/arm/mm/cache-l2x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 4a785fc..5e65ca8 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1174,8 +1174,8 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		*aux_mask &= ~L2X0_AUX_CTRL_ASSOC_MASK;
 		break;
 	default:
-		pr_err("PL310 OF: cache setting yield illegal associativity\n");
-		pr_err("PL310 OF: %d calculated, only 8 and 16 legal\n", assoc);
+		pr_err("L2C-310 OF cache associativity %d invalid, only 8 or 16 permitted\n",
+		       assoc);
 		break;
 	}
 }
-- 
1.9.1
