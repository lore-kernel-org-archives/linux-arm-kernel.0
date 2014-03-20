From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Wed, 19 Mar 2014 20:54:25 -0400
Subject: [PATCH v1 2/2] Documentation: devicetree: Add new binding for PSCIv0.2
In-Reply-To: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1395276865-6868-2-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI v0.2+ spec defines static values for PSCI function IDs.
Add a new binding entry so that pre v0.2 implementations can
use DT entries for function IDs and v0.2+ implementations use
static entries as defined by the PSCIv0.2 specification.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
index 433afe9..a808284 100644
--- a/Documentation/devicetree/bindings/arm/psci.txt
+++ b/Documentation/devicetree/bindings/arm/psci.txt
@@ -21,7 +21,11 @@ to #0.
 
 Main node required properties:
 
- - compatible    : Must be "arm,psci"
+ - compatible    : "arm,psci" : pre PSCIv0.2 spec implementations use this
+                   to get the function IDs from DT entries.
+
+                   "arm,psci-0.2": PSCIv0.2+ spec implementations use static
+                   values for function IDs as defined in the spec.
 
  - method        : The method of calling the PSCI firmware. Permitted
                    values are:
-- 
1.8.3.2
