From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 25 Oct 2016 08:26:38 -0700
Subject: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
In-Reply-To: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update domain-idle-state binding to use "domain-idle-state" compatible
from Documentation/devicetree/bindings/arm/idle-states.txt.

Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index e165036..6fb53a3 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -30,8 +30,9 @@ Optional properties:
    available in the next section.
 
 - domain-idle-states : A phandle of an idle-state that shall be soaked into a
-                generic domain power state. The idle state definitions are
-                compatible with arm,idle-state specified in [1].
+                generic domain power state. The idle state definitions must be
+                compatible with "domain-idle-state" as well as
+                "arm,idle-state" as defined in [1].
   The domain-idle-state property reflects the idle state of this PM domain and
   not the idle states of the devices or sub-domains in the PM domain. Devices
   and sub-domains have their own idle-states independent of the parent
@@ -85,7 +86,7 @@ Example 3:
 	};
 
 	DOMAIN_RET: state at 0 {
-		compatible = "arm,idle-state";
+		compatible = "domain-idle-state", "arm,idle-state";
 		reg = <0x0>;
 		entry-latency-us = <1000>;
 		exit-latency-us = <2000>;
@@ -93,7 +94,7 @@ Example 3:
 	};
 
 	DOMAIN_PWR_DN: state at 1 {
-		compatible = "arm,idle-state";
+		compatible = "domain-idle-state", "arm,idle-state";
 		reg = <0x1>;
 		entry-latency-us = <5000>;
 		exit-latency-us = <8000>;
-- 
2.7.4
