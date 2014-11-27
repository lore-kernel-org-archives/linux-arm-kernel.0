From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Nov 2014 12:20:48 +0100
Subject: [PATCH v4 2/7] regulator: dt-bindings: Document the ena-gpios property
In-Reply-To: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417087253-12306-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new properties for regulators (ena-gpios and
ena-gpio-open-drain) for enabling control over GPIO.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 4e7ed762b3bb..dad57b3badc7 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -30,6 +30,10 @@ Optional properties:
 	- regulator-off-in-suspend: regulator should be off in suspend state.
 	- regulator-suspend-microvolt: regulator should be set to this voltage
 	  in suspend.
+- ena-gpios: GPIO to use for enable control. Actual implementation depends
+  on regulator driver. The bindings documentation for given driver describes
+  which regulator actually supports it.
+- ena-gpio-open-drain: GPIO is open drain type.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
1.9.1
