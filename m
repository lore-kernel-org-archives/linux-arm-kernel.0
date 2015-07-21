From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 21 Jul 2015 21:53:01 +0530
Subject: [PATCH-v2 1/2] mfd: devicetree: bindings: 88pm800: Add DT property
 for dual phase enable
In-Reply-To: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1437495782-15767-2-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 family of device supports dual phase mode on BUCK1 supply
providing total 6A capacity.
Note that by default they operate independently with 3A capacity.

This patch updates the devicetree binding with DT property
to enable dual-phase mode on BUCK1.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
index dec842f..2c82fcb 100644
--- a/Documentation/devicetree/bindings/mfd/88pm800.txt
+++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
@@ -9,6 +9,12 @@ Required parent device properties:
 - #interrupt-cells 	: should be 1.
 			  The cell is the 88pm80x local IRQ number
 
+Optional properties :
+- marvell,88pm860-buck1-dualphase-en  : If set, enable dual phase on BUCK1,
+  providing 6A capacity.
+  Without this both BUCK1A and BUCK1B operates independently with 3A capacity.
+  (This property is only applicable to 88PM860)
+
 88pm80x family of devices consists of varied group of sub-devices:
 
 Device		 	Supply Names	 Description
-- 
1.9.1
