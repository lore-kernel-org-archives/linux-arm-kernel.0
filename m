From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 25 Aug 2011 17:43:33 -0600
Subject: [PATCH v3 02/13] docs/dt: Document nvidia, tegra20-gpio's nvidia,
	enabled-gpios property
In-Reply-To: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
Message-ID: <1314315824-9687-3-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
index eb4b530..b22fff3 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -6,3 +6,23 @@ Required properties:
   second cell is used to specify optional parameters:
   - bit 0 specifies polarity (0 for normal, 1 for inverted)
 - gpio-controller : Marks the device node as a GPIO controller.
+
+Optional properties:
+- nvidia,enabled-gpios : The list of GPIOs that should be controlled by the
+  GPIO controller rather than the pinmux controller.
+
+Example of a gpio-controller node:
+
+	gpio: gpio at 6000d000 {
+		compatible = "nvidia,tegra20-gpio";
+		reg = < 0x6000d000 0x1000 >;
+		interrupts = < 64 65 66 67 87 119 121 >;
+		#gpio-cells = <2>;
+		gpio-controller;
+		nvidia,enabled-gpios = <
+			69	// TEGRA_GPIO_PI5 SD2_CD
+			57	// TEGRA_GPIO_PH1 SD2_WP
+			155	// TEGRA_GPIO_PT3 SD2_POWER
+		>;
+	};
+
-- 
1.7.0.4
