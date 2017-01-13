From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Fri, 13 Jan 2017 13:05:52 -0200
Subject: [PATCH v3 1/2] dt-bindings: mmc: add DT binding for S3C24XX
 MMC/SD/SDIO controller
In-Reply-To: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
References: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <1484319953-6479-2-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the device tree bindings description for Samsung S3C24XX
MMC/SD/SDIO controller, used as a connectivity interface with external
MMC, SD and SDIO storage mediums.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
new file mode 100644
index 000000000000..d09dbf4b3824
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
@@ -0,0 +1,34 @@
+* Samsung's S3C24XX MMC/SD/SDIO controller device tree bindings
+
+Samsung's S3C24XX MMC/SD/SDIO controller is used as a connectivity interface
+with external MMC, SD and SDIO storage mediums.
+
+This file documents differences between the core mmc properties described by
+mmc.txt and the properties used by the Samsung S3C24XX MMC/SD/SDIO controller
+implementation.
+
+Required SoC Specific Properties:
+- compatible: should be one of the following
+  - "samsung,s3c2410-sdi": for controllers compatible with s3c2410
+  - "samsung,s3c2412-sdi": for controllers compatible with s3c2412
+  - "samsung,s3c2440-sdi": for controllers compatible with s3c2440
+- clocks: Should reference the controller clock
+- clock-names: Should contain "sdi"
+
+Example:
+	mmc0: mmc at 5a000000 {
+		compatible = "samsung,s3c2440-sdi";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdi_pins>;
+		reg = <0x5a000000 0x100000>;
+		interrupts = <0 0 21 3>;
+		clocks = <&clocks PCLK_SDI>;
+		clock-names = "sdi";
+		bus-width = <4>;
+		cd-gpios = <&gpg 8 GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gph 8 GPIO_ACTIVE_LOW>;
+	};
+
+	Note: This example shows both SoC specific and board specific properties
+	in a single device node. The properties can be actually be separated
+	into SoC specific node and board specific node.
-- 
1.9.1
