From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 13 Aug 2014 15:41:22 +0300
Subject: [PATCH v2 2/5] of: Add nvidia,
 controller-id property to Tegra I2C bindings
In-Reply-To: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1407933685-12404-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes, hardware blocks want to issue requests to devices
connected to I2C buses by itself. In such case, the bus the
target device resides on must be configured into a register.
For this purpose, each I2C controller has a defined ID known
by the hardware. Add a property for these IDs to the device tree
bindings, so that drivers can know what ID to write to a hardware
register when configuring a block that sends I2C messages autonomously.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index 87507e9..e9e5994 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -57,6 +57,10 @@ Required properties:
   - rx
   - tx
 
+Optional properties:
+- nvidia,controller-id: ID of controller when referred to in
+                        hardware registers.
+
 Example:
 
 	i2c at 7000c000 {
@@ -71,5 +75,6 @@ Example:
 		reset-names = "i2c";
 		dmas = <&apbdma 16>, <&apbdma 16>;
 		dma-names = "rx", "tx";
+		nvidia,controller-id = <0>;
 		status = "disabled";
 	};
-- 
1.8.1.5
