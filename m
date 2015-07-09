From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 17:17:08 +0530
Subject: [PATCH 3/6] mfd: devicetree: bindings: 88pm800: Add DT property for
 32KHz output enable
In-Reply-To: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436442431-3471-4-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM800 family of device supports output of 32KHz clock (low jitter)
on CLK32K2/3 pin which can be supplied to other peripherals on the board.

This patch adds the devicetree binding to enable this feature.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
index dec842f..ae1311c 100644
--- a/Documentation/devicetree/bindings/mfd/88pm800.txt
+++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
@@ -9,6 +9,12 @@ Required parent device properties:
 - #interrupt-cells 	: should be 1.
 			  The cell is the 88pm80x local IRQ number
 
+Optional properties :
+ - marvell,88pm800-32khz-xolj-out-en	: If set, driver will enable low jitter
+   version of 32Khz clock output on
+      CLK32K3 - for 88pm800
+      CLK32K2 - for 88pm860
+
 88pm80x family of devices consists of varied group of sub-devices:
 
 Device		 	Supply Names	 Description
-- 
1.9.1
