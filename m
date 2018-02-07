From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  7 Feb 2018 14:45:47 +0100
Subject: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Message-ID: <20180207134553.13510-2-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a simple document for the DaVinci genpd driver. We use clock pm
exclusively hence no reg property.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt

diff --git a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
new file mode 100644
index 000000000000..935d063c7b35
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
@@ -0,0 +1,13 @@
+Device tree bindings for the genpd driver for Texas Instruments DaVinci SoCs
+
+Required properties:
+
+- compatible:           must be "ti,davinci-pm-domains"
+- #power-domain-cells:  must be 0
+
+Example:
+
+pwc1: power-controller at 227000 {
+	compatible = "ti,davinci-pm-domains";
+	#power-domain-cells = <0>;
+};
-- 
2.16.1
