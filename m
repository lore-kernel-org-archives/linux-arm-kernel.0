From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  2 Sep 2014 10:15:19 +0200
Subject: [PATCH V2 4/4] clk: mvebu: armada-375: Fix the description of the SAR
 in the comment
In-Reply-To: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
References: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1409645719-20003-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For dealing with the code we use the SAR1 and not the SAR0. The code
was correct, and now the comments too.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/armada-375.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-375.c b/drivers/clk/mvebu/armada-375.c
index c991a4d95e10..c7af2242b796 100644
--- a/drivers/clk/mvebu/armada-375.c
+++ b/drivers/clk/mvebu/armada-375.c
@@ -27,14 +27,14 @@
  * all modified at the same time, and not separately as for the Armada
  * 370 or the Armada XP SoCs.
  *
- * SAR0[21:17]   : CPU frequency    DDR frequency   L2 frequency
+ * SAR1[21:17]   : CPU frequency    DDR frequency   L2 frequency
  *		 6   =  400 MHz	    400 MHz	    200 MHz
  *		 15  =  600 MHz	    600 MHz	    300 MHz
  *		 21  =  800 MHz	    534 MHz	    400 MHz
  *		 25  = 1000 MHz	    500 MHz	    500 MHz
  *		 others reserved.
  *
- * SAR0[22]   : TCLK frequency
+ * SAR1[22]   : TCLK frequency
  *		 0 = 166 MHz
  *		 1 = 200 MHz
  */
-- 
1.9.1
