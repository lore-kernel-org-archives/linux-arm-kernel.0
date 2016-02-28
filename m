From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:53 +0000
Subject: [PATCH v5 02/20] clk: bcm2835: clean up coding style issues
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Fix all the checkpatch complaints for clk-bcm2835.c.
Specifically:
* indention
* missing spin lock comments
* multiple empty lines

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index d3009a6..3aa3e7a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -12,9 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */

 /**
@@ -297,7 +294,7 @@
 struct bcm2835_cprman {
 	struct device *dev;
 	void __iomem *regs;
-	spinlock_t regs_lock;
+	spinlock_t regs_lock; /* spinlock for all clocks */
 	const char *osc_name;

 	struct clk_onecell_data onecell;
@@ -325,12 +322,12 @@ void __init bcm2835_init_clocks(void)
 	int ret;

 	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
-					126000000);
+				      126000000);
 	if (IS_ERR(clk))
 		pr_err("apb_pclk not registered\n");

 	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
-					3000000);
+				      3000000);
 	if (IS_ERR(clk))
 		pr_err("uart0_pclk not registered\n");
 	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
@@ -338,7 +335,7 @@ void __init bcm2835_init_clocks(void)
 		pr_err("uart0_pclk alias not registered\n");

 	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
-					125000000);
+				      125000000);
 	if (IS_ERR(clk))
 		pr_err("uart1_pclk not registered\n");
 	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
@@ -1291,7 +1288,7 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 }

 static int bcm2835_clock_determine_rate(struct clk_hw *hw,
-		struct clk_rate_request *req)
+					struct clk_rate_request *req)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct clk_hw *parent, *best_parent = NULL;
@@ -1349,7 +1346,6 @@ static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
 	return (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
 }

-
 static const struct clk_ops bcm2835_clock_clk_ops = {
 	.is_prepared = bcm2835_clock_is_on,
 	.prepare = bcm2835_clock_on,
--
1.7.10.4
