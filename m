From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  6 Mar 2014 22:44:43 -0800
Subject: [PATCH 4/7] pinctrl: msm: Drop OF_IRQ dependency
In-Reply-To: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
References: <1394174686-8358-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1394174686-8358-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver doesn't rely on any functionality living in
drivers/of/irq.c to compile. Drop this dependency.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index be361b7cd30f..32b6b49f28ec 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -224,7 +224,7 @@ config PINCTRL_MSM
 
 config PINCTRL_MSM8X74
 	tristate "Qualcomm 8x74 pin controller driver"
-	depends on GPIOLIB && OF && OF_IRQ
+	depends on GPIOLIB && OF
 	select PINCTRL_MSM
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
