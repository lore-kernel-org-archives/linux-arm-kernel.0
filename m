From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu,  9 Jul 2015 17:17:10 +0530
Subject: [PATCH 5/6] mfd: devicetree: bindings: 88pm800: Add DT property for
 dual phase enable
In-Reply-To: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1436442431-3471-6-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

88PM860 family of device supports dual phase mode on BUCK1 supply
providing total 6A capacity.
Note that by default they operate independently with 3A capacity.

This patch adds the devicetree binding to enable this
feature.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
index ae1311c..c756b31 100644
--- a/Documentation/devicetree/bindings/mfd/88pm800.txt
+++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
@@ -15,6 +15,12 @@ Optional properties :
       CLK32K3 - for 88pm800
       CLK32K2 - for 88pm860
 
+   (Applicable only to PXA910 family):
+
+ - marvell,88pm860-buck1-dualphase-en	: If set, enable dual phase on BUCK1,
+   providing 6A capacity.
+   Without this both BUCK1A and BUCK1B operates independently with 3A capacity.
+
 88pm80x family of devices consists of varied group of sub-devices:
 
 Device		 	Supply Names	 Description
-- 
1.9.1
