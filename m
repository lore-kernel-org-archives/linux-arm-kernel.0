From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Mar 2015 11:54:08 +0000
Subject: [PATCH v3 1/4] dt: pmu: extend ARM PMU binding to allow for explicit
 interrupt affinity
In-Reply-To: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
References: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
Message-ID: <1425642851-27450-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ARM PMU binding relies on the PMU interrupts being listed in
CPU logical order, which the device-tree author simply cannot know
anything about.

This patch introduces a new "interrupt-affinity" property, which makes
the relationship between the PMU interrupts and their corresponding
CPU explicit.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/devicetree/bindings/arm/pmu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
index 75ef91d08f3b..f52d05660dc9 100644
--- a/Documentation/devicetree/bindings/arm/pmu.txt
+++ b/Documentation/devicetree/bindings/arm/pmu.txt
@@ -24,6 +24,13 @@ Required properties:
 
 Optional properties:
 
+- interrupt-affinity : Valid only when using SPIs, specifies a list of phandles
+                       to CPU nodes corresponding directly to the affinity of
+		       the SPIs listed in the interrupts property.
+
+		       This property should be present when there is more than
+		       a single SPI.
+
 - qcom,no-pc-write : Indicates that this PMU doesn't support the 0xc and 0xd
                      events.
 
-- 
2.1.4
