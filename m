From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 2 Jan 2018 13:44:51 +0100
Subject: [PATCHv2] Device tree binding for Avago APDS990X light sensor
In-Reply-To: <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
Message-ID: <20180102124450.GA18659@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Filip Matijevi? <filip.matijevic.pz@gmail.com>

This prepares binding for light sensor used in Nokia N9.

Signed-off-by: Filip Matijevi? <filip.matijevic.pz@gmail.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
new file mode 100644
index 0000000..480c0b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
@@ -0,0 +1,41 @@
+Avago APDS990X driver
+
+https://docs.broadcom.com/docs/AV02-2867EN
+
+Required properties:
+- compatible: "avago,apds990x"
+- reg: address on the I2C bus
+- interrupts: external interrupt line number
+- vdd-supply: power supply for VDD
+- vled-supply: power supply for LEDA
+- avago,ga: Glass attenuation
+- avago,cf1: Clear channel factor 1
+- avago,irf1: IR channel factor 1
+- avago,cf2: Clear channel factor 2
+- avago,irf2: IR channel factor 2
+- avago,df: Device factor
+- avago,pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
+- avago,ppcount: Proximity pulse count
+
+Example (Nokia N9):
+
+	als_ps at 39 {
+		compatible = "avago,apds990x";
+		reg = <0x39>;
+
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_LOW)>; /* gpio_83 */
+
+		vdd-supply = <&vaux1>;
+		vled-supply = <&vbat>;
+
+		avago,ga	= <168834>;
+		avago,cf1	= <4096>;
+		avago,irf1	= <7824>;
+		avago,cf2	= <877>;
+		avago,irf2	= <1575>;
+		avago,df	= <52>;
+
+		avago,pdrive	= <0x2>; /* APDS_IRLED_CURR_25mA */
+		avago,ppcount	= <5>;
+	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/275ee9b9/attachment.sig>
