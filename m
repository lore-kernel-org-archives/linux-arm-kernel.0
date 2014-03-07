From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  6 Mar 2014 22:44:42 -0800
Subject: [PATCH 3/7] pinctrl: msm: Drop unused includes
In-Reply-To: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
References: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1394174686-8358-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These includes are unused or can be handled via forward
declarations. Remove them.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/pinctrl-msm.c     | 1 -
 drivers/pinctrl/pinctrl-msm.h     | 5 +----
 drivers/pinctrl/pinctrl-msm8x74.c | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index 19b0de89dc07..5daad720ecbb 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -28,7 +28,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
 #include "core.h"
diff --git a/drivers/pinctrl/pinctrl-msm.h b/drivers/pinctrl/pinctrl-msm.h
index 206e782e2daa..8fbe9fb19f36 100644
--- a/drivers/pinctrl/pinctrl-msm.h
+++ b/drivers/pinctrl/pinctrl-msm.h
@@ -13,10 +13,7 @@
 #ifndef __PINCTRL_MSM_H__
 #define __PINCTRL_MSM_H__
 
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/machine.h>
+struct pinctrl_pin_desc;
 
 /**
  * struct msm_function - a pinmux function
diff --git a/drivers/pinctrl/pinctrl-msm8x74.c b/drivers/pinctrl/pinctrl-msm8x74.c
index f944bf2172ef..bb5ded69f963 100644
--- a/drivers/pinctrl/pinctrl-msm8x74.c
+++ b/drivers/pinctrl/pinctrl-msm8x74.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
 
 #include "pinctrl-msm.h"
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
