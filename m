From: marco.franchi@nxp.com (Marco Franchi)
Date: Tue, 9 Jan 2018 09:46:25 -0200
Subject: [PATCH 3/3] ARM: dts: imx7d-sdb: Add support for mpl3115 sensor
In-Reply-To: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
References: <1515498385-23198-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1515498385-23198-3-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 7D SDB has a MPL3115 Pressure sensor.
Add support for this sensor, which is included in the trivial i2c devices 
and according to the bindings documentation, just need a compatible field 
and an address.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a7a5dc7..a20c942 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -336,6 +336,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	mpl3115 at 60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
 };
 
 &i2c3 {
-- 
2.7.4
