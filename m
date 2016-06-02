From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Jun 2016 21:30:27 +0200
Subject: [PATCH] device tree description for AD5820 camera auto-focus coil
In-Reply-To: <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
References: <574049EF.2090208@gmail.com> <20160524090433.GA1277@amd>
 <20160524091746.GA14536@amd>
 <20160525212659.GK26360@valkosipuli.retiisi.org.uk>
 <20160527205140.GA26767@amd>
 <20160531212222.GP26360@valkosipuli.retiisi.org.uk>
 <20160531213437.GA28397@amd>
 <20160601152439.GQ26360@valkosipuli.retiisi.org.uk>
 <20160601220840.GA21946@amd>
 <20160602074544.GR26360@valkosipuli.retiisi.org.uk>
Message-ID: <20160602193027.GB7984@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add documentation for ad5820 device tree binding.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
new file mode 100644
index 0000000..fb70ca5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -0,0 +1,19 @@
+* Analog Devices AD5820 autofocus coil
+
+Required Properties:
+
+  - compatible: Must contain "adi,ad5820"
+
+  - reg: I2C slave address
+
+  - VANA-supply: supply of voltage for VANA pin
+
+Example:
+
+       ad5820: coil at 0c {
+               compatible = "adi,ad5820";
+               reg = <0x0c>;
+
+               VANA-supply = <&vaux4>;
+       };
+

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
