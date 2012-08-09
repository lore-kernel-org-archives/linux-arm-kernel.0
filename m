From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  9 Aug 2012 16:47:36 +0100
Subject: [PATCH 10/22] Documentation: Define the MSP Driver Device Tree
 bindings
In-Reply-To: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344527268-5964-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the required documentation for the new Device Tree
bindings pertaining to the MSP CPU-side DAI Driver.

CC: alsa-devel at alsa-project.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/sound/ux500-msp.txt        |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt

diff --git a/Documentation/devicetree/bindings/sound/ux500-msp.txt b/Documentation/devicetree/bindings/sound/ux500-msp.txt
new file mode 100644
index 0000000..99acd9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ux500-msp.txt
@@ -0,0 +1,43 @@
+* ux500 MSP (CPU-side Digital Audio Interface)
+
+Required properties:
+ - compatible       :"stericsson,ux500-msp-i2s"
+ - reg              : Physical base address and length of the device's registers.
+
+Optional properties:
+ - interrupts       : The interrupt output from the device.
+ - interrupt-parent : The parent interrupt controller.
+ - <name>-supply    : Phandle to the regulator <name> supply
+
+Example:
+
+	sound {
+		compatible = "stericsson,snd-soc-mop500";
+
+		stericsson,platform-pcm-dma = <&pcm>;
+		stericsson,cpu-dai = <&msp1 &msp3>;
+		stericsson,audio-codec = <&codec>;
+	};
+
+	pcm: ux500-pcm {
+		compatible = "stericsson,ux500-pcm";
+	};
+
+	msp1: msp at 80124000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80124000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	msp3: msp at 80125000 {
+		compatible = "stericsson,ux500-msp-i2s";
+		reg = <0x80125000 0x1000>;
+		interrupts = <0 62 0x4>;
+		v-ape-supply = <&db8500_vape_reg>;
+	};
+
+	codec: ab8500-codec {
+		compatible = "stericsson,ab8500-codec";
+		stericsson,earpeice-cmv = <950>; /* Units in mV. */
+	};
-- 
1.7.9.5
