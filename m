From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Oct 2012 23:38:54 -0700
Subject: [PATCH 2/3] clk: Fix documentation typos
In-Reply-To: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
References: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1349332735-20096-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some minor typos in the documentation for the ops structure.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/clk-provider.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5a548e3..0571261 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -57,9 +57,9 @@ struct clk_hw;
  * 		This function must not sleep. Optional, if this op is not
  * 		set then the enable count will be used.
  *
- * @recalc_rate	Recalculate the rate of this clock, by quering hardware.  The
+ * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
  * 		parent rate is an input parameter.  It is up to the caller to
- * 		insure that the prepare_mutex is held across this call.
+ * 		ensure that the prepare_mutex is held across this call.
  * 		Returns the calculated rate.  Optional, but recommended - if
  * 		this op is not set then clock rate will be initialized to 0.
  *
@@ -93,7 +93,7 @@ struct clk_hw;
  * implementations to split any work between atomic (enable) and sleepable
  * (prepare) contexts.  If enabling a clock requires code that might sleep,
  * this must be done in clk_prepare.  Clock enable code that will never be
- * called in a sleepable context may be implement in clk_enable.
+ * called in a sleepable context may be implemented in clk_enable.
  *
  * Typically, drivers will call clk_prepare when a clock may be needed later
  * (eg. when a device is opened), and clk_enable when the clock is actually
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
