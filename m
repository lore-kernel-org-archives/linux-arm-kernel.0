From: m.niestroj@grinn-global.com (Marcin Niestroj)
Date: Thu,  3 Aug 2017 09:37:13 +0200
Subject: [PATCH v2] ARM: dts: imx6ul-liteboard: Support poweroff
Message-ID: <20170803073713.14889-1-m.niestroj@grinn-global.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support proper system power-off, which disables main regulator. This
results in much lower power consumption and support of power-on issued
by button press.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
Changes v1 -> v2:
 * Add new node in alphabetical order (suggested by Shawn)

 arch/arm/boot/dts/imx6ul-liteboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-liteboard.dts b/arch/arm/boot/dts/imx6ul-liteboard.dts
index ed1d891d6a89..1d863a16bcf0 100644
--- a/arch/arm/boot/dts/imx6ul-liteboard.dts
+++ b/arch/arm/boot/dts/imx6ul-liteboard.dts
@@ -124,6 +124,10 @@
 	};
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.13.3
