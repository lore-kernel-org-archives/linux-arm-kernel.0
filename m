From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  3 Oct 2012 23:38:53 -0700
Subject: [PATCH 1/3] clk: Document .is_enabled op
In-Reply-To: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
References: <1349332735-20096-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1349332735-20096-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing kernel-doc for this op.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/clk-provider.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 710c6cb..5a548e3 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -53,6 +53,10 @@ struct clk_hw;
  * @disable:	Disable the clock atomically. Called with enable_lock held.
  * 		This function must not sleep.
  *
+ * @is_enabled:	Queries the hardware to determine if the clock is enabled.
+ * 		This function must not sleep. Optional, if this op is not
+ * 		set then the enable count will be used.
+ *
  * @recalc_rate	Recalculate the rate of this clock, by quering hardware.  The
  * 		parent rate is an input parameter.  It is up to the caller to
  * 		insure that the prepare_mutex is held across this call.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
