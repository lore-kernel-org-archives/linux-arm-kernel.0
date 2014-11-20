From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Nov 2014 22:53:26 +0100
Subject: [PATCH 2/2] Documentation: bindings: add doc for the Berlin USB PHY
In-Reply-To: <1416520406-1852-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1416520406-1852-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1416520406-1852-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

Document the bindings of the Marvell Berlin USB PHY driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
Split-off patches from latest Berlin USB PHY patches
  https://lkml.kernel.org/g/1416231347-27193-1-git-send-email-antoine.tenart at free-electrons.com

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 .../devicetree/bindings/phy/berlin-usb-phy.txt     |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/berlin-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/berlin-usb-phy.txt b/Documentation/devicetree/bindings/phy/berlin-usb-phy.txt
new file mode 100644
index 0000000..be33780
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/berlin-usb-phy.txt
@@ -0,0 +1,16 @@
+* Marvell Berlin USB PHY
+
+Required properties:
+- compatible: "marvell,berlin2-usb-phy" or "marvell,berlin2cd-usb-phy"
+- reg: base address and length of the registers
+- #phys-cells: should be 0
+- resets: reference to the reset controller
+
+Example:
+
+	usb-phy at f774000 {
+		compatible = "marvell,berlin2-usb-phy";
+		reg = <0xf774000 0x128>;
+		#phy-cells = <0>;
+		resets = <&chip 0x104 14>;
+	};
-- 
1.7.2.5
