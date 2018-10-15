From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 15 Oct 2018 16:03:34 +0200
Subject: [PATCH 2/4] ASoC: dt-bindings: add mclk support to cs42l51
In-Reply-To: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
References: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1539612216-12602-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks properties to cs42l51 Cirrus codec,
to support master clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/cs42l51.txt   | 17 +++++++++++++++++
 Documentation/devicetree/bindings/trivial-devices.txt |  1 -
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
new file mode 100644
index 000000000000..4b5de33ce377
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -0,0 +1,17 @@
+CS42L51 audio CODEC
+
+Optional properties:
+
+  - clocks : a list of phandles + clock-specifiers, one for each entry in
+    clock-names
+
+  - clock-names : must contain "MCLK"
+
+Example:
+
+cs42l51: cs42l51 at 4a {
+	compatible = "cirrus,cs42l51";
+	reg = <0x4a>;
+	clocks = <&mclk_prov>;
+	clock-names = "MCLK";
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..69c934aec13b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -35,7 +35,6 @@ at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
 dallas,ds1672		Dallas DS1672 Real-time Clock
-- 
2.7.4
