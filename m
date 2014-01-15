From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 10:47:21 -0800
Subject: [PATCH v5 01/14] reset: Silence warning in reset-controller.h
In-Reply-To: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
References: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389811654-21397-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a user of <linux/reset-controller.h> doesn't include
<linux/of.h> before including reset-controller.h they'll get a
warning as follows:

  include/linux/reset-controller.h:44:17:
  warning: 'struct of_phandle_args' declared inside parameter list

This is because of_phandle_args is not forward declared. Add the
declaration to silence this warning.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/reset-controller.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 2f61311ae3e0..41a4695fde08 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -21,6 +21,7 @@ struct reset_control_ops {
 
 struct module;
 struct device_node;
+struct of_phandle_args;
 
 /**
  * struct reset_controller_dev - reset controller entity that might
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
