From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 30 Sep 2015 14:39:18 +0800
Subject: [PATCH 2/2] regulator: act8865: add DT binding for property
 "active-semi, vsel-high"
In-Reply-To: <1443595158-550-1-git-send-email-wenyou.yang@atmel.com>
References: <1443595158-550-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1443595158-550-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT property "active-semi,vsel-high" to indicate the VSEL pin
is high. If this property is missing, then assume the VSEL pin is
low(0).

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 .../bindings/regulator/act8865-regulator.txt       |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
index e91485d..6067d98 100644
--- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
@@ -8,6 +8,8 @@ Required properties:
 Optional properties:
 - system-power-controller: Telling whether or not this pmic is controlling
   the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
+- active-semi,vsel-high: Indicates the VSEL pin is high.
+  If this property is missing, assume the VSEL pin is low(0).
 
 Optional input supply properties:
 - for act8600:
@@ -49,6 +51,7 @@ Example:
 			pmic: act8865 at 5b {
 				compatible = "active-semi,act8865";
 				reg = <0x5b>;
+				active-semi,vsel-high;
 				status = "disabled";
 
 				regulators {
-- 
1.7.9.5
