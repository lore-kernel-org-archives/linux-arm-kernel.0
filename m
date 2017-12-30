From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Sat, 30 Dec 2017 01:12:47 +0000
Subject: [PATCH 08/33] clk: bcm2835: change bcm2835_pll_rate_from_divisors to
 return unsigned long
In-Reply-To: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514596392-22270-9-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835_pll_rate_from_divisors() returns a value directly as the return
value to round_rate(). clk_ops->round_rate() has been changed to an
unsigned long so for the sake of completeness and neatness this patch
updates the helper function to return the same data-type.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Phil Elwell <phil@raspberrypi.org>
Cc: linux-clk at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/bcm/clk-bcm2835.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index c215dc9..fb2b012 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -541,8 +541,9 @@ static void bcm2835_pll_choose_ndiv_and_fdiv(unsigned long rate,
 	*fdiv = div & ((1 << A2W_PLL_FRAC_BITS) - 1);
 }
 
-static long bcm2835_pll_rate_from_divisors(unsigned long parent_rate,
-					   u32 ndiv, u32 fdiv, u32 pdiv)
+static unsigned long bcm2835_pll_rate_from_divisors(unsigned long parent_rate,
+						    u32 ndiv, u32 fdiv,
+						    u32 pdiv)
 {
 	u64 rate;
 
-- 
2.7.4
