From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Fri, 16 May 2014 10:49:03 +0200
Subject: [PATCH v2 3/3] ARM: dts: kirkwood: add kirkwood-km_fixedeth DTS file
In-Reply-To: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
References: <1400230143-15620-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1400230143-15620-4-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Besides our Kirkwood Reference design, there is another group of board
on which the eth interface is not connected to a phy but to a switch for
some board internal communication. For these designs, the memory also is
raised to 256MB.

The configuration of the switch is handled by an EEPROM or by the
bootloader, but on the kirkwood side, the port is always configured as
1000 Mbits, full duplex.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

---

Changes in v2:
- Take advantage of the kirkwood-km_common.dtsi file for
  kirkwood-km_fixedeth.dts

 arch/arm/boot/dts/kirkwood-km_fixedeth.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-km_fixedeth.dts

diff --git a/arch/arm/boot/dts/kirkwood-km_fixedeth.dts b/arch/arm/boot/dts/kirkwood-km_fixedeth.dts
new file mode 100644
index 0000000..9895f2b
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-km_fixedeth.dts
@@ -0,0 +1,23 @@
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-98dx4122.dtsi"
+#include "kirkwood-km_common.dtsi"
+
+/ {
+	model = "Keymile Kirkwood Fixed Eth";
+	compatible = "keymile,km_fixedeth", "marvell,kirkwood-98DX4122", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		speed = <1000>;  /* <SPEED_1000> */
+		duplex = <1>; /* <DUPLEX_FULL> */
+	};
+};
-- 
1.8.0.1
