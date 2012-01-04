From: swarren@nvidia.com (Stephen Warren)
Date: Wed,  4 Jan 2012 11:39:34 -0700
Subject: [PATCH 2/6] dt: tegra gpio: Flesh out binding documentation
In-Reply-To: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325702378-20863-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the required reg and interrupts properties.
Add a complete example.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
index eb4b530..50b363c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -2,7 +2,25 @@ NVIDIA Tegra 2 GPIO controller
 
 Required properties:
 - compatible : "nvidia,tegra20-gpio"
+- reg : Physical base address and length of the controller's registers.
+- interrupts : The interrupt outputs from the controller.
 - #gpio-cells : Should be two. The first cell is the pin number and the
   second cell is used to specify optional parameters:
   - bit 0 specifies polarity (0 for normal, 1 for inverted)
 - gpio-controller : Marks the device node as a GPIO controller.
+
+Example:
+
+gpio: gpio at 6000d000 {
+	compatible = "nvidia,tegra20-gpio";
+	reg = < 0x6000d000 0x1000 >;
+	interrupts = < 0 32 0x04
+		       0 33 0x04
+		       0 34 0x04
+		       0 35 0x04
+		       0 55 0x04
+		       0 87 0x04
+		       0 89 0x04 >;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
-- 
1.7.0.4
