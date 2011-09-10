From: rklein@nvidia.com (Rhyland Klein)
Date: Fri,  9 Sep 2011 17:47:49 -0700
Subject: [PATCH 2/2 v2] power: bq20z75: Add Device Tree Binding
In-Reply-To: <1315615669-8701-1-git-send-email-rklein@nvidia.com>
References: <1315615669-8701-1-git-send-email-rklein@nvidia.com>
Message-ID: <1315615669-8701-2-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding the binding for the TI bq20z75 fuel gadge and the
bq20z75 driver.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 .../bindings/power_supply/ti_bq20z75.txt           |   25 ++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ti_bq20z75.txt

diff --git a/Documentation/devicetree/bindings/power_supply/ti_bq20z75.txt b/Documentation/devicetree/bindings/power_supply/ti_bq20z75.txt
new file mode 100644
index 0000000..3deccfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/ti_bq20z75.txt
@@ -0,0 +1,25 @@
+TI bq20z75
+~~~~~~~~~~
+
+Required properties :
+ - compatible : "ti,bq20z75"
+
+Optional properties :
+ - i2c-retry-count : The number of times to retry i2c transactions on i2c
+   IO failure.
+ - poll-retry-count : The number of times to try looking for new status
+   after an external change notification.
+ - battery-detect : The GPIO which is used to detect battery presence.
+ - battery-detect-present : The state of the GPIO when the battery is
+   present ( 0 or 1).
+
+Example:
+
+	bq20z75 at b {
+		compatible = "ti,bq20z75";
+		reg = < 0xb >;
+		i2c-retry-count = <2>;
+		poll-retry-count = <10>;
+		battery-detect = <314>;
+		battery-detect-present = <0>;
+	}
-- 
1.7.6
