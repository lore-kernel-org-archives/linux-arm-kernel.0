From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Feb 2018 09:24:45 +0100
Subject: [PATCHv3] tlv320dac33: Add device tree bindings
In-Reply-To: <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
References: <20180129230539.GA18280@amd> <20180131190112.GA31608@amd>
 <20b9ff40-a869-a165-07a2-2a103830efb3@ti.com>
Message-ID: <20180205082445.GA18274@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds device tree bindings for tlv320dac33.c.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
new file mode 100644
index 0000000..aee0a87
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
@@ -0,0 +1,32 @@
+Texas Instruments - tlv320dac33 Codec module
+
+The tlv320dac33 serial control bus communicates through I2C protocols.
+
+Required properties:
+
+- compatible - "ti,tlv320dac33"
+- reg - I2C slave address
+- ti,burst-bclkdiv - BCLK divider value in burst mode. Valid range is 1..255.
+
+Optional properties:
+
+- reset-gpios      - gpio pin to power the device, active high.
+
+- interrupts       - The interrupt output from the device.
+- interrupt-parent - The parent interrupt controller.
+
+- ti,keep-bclk     - Keep the BCLK running in FIFO modes.
+
+Example:
+
+tlv320dac33: audio-codec at 19 {
+	compatible = "ti,tlv320dac33";
+	reg = <0x19>;
+
+	interrupt-parent = <&gpio2>;
+	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
+	reset-gpios = <&gpio2 28 0>; /* gpio_60 */
+
+	ti,keep-bclk;
+	ti,burst-bclkdiv = <3>;
+};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180205/95ca6f88/attachment.sig>
