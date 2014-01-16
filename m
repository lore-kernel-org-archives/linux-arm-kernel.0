From: denis@eukrea.com (Denis Carikli)
Date: Thu, 16 Jan 2014 12:08:37 +0100
Subject: [PATCHv10][ 2/2] ARM: dts: cpuimx51 Add touchscreen support.
In-Reply-To: <1389870518-4982-1-git-send-email-denis@eukrea.com>
References: <1389870518-4982-1-git-send-email-denis@eukrea.com>
Message-ID: <1389870518-4982-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Eric B?nard <eric@eukrea.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v9->v10:
- Reduced Cc list, not to bother unrelated subsystem maintainers.
- Rebased: the pinctrl node is already in linux-next.
- Updated tsc2007 pinctrl properties accordingly.
- Cosmetic fix: reordered the tsc2007 node properties.

ChangeLog v8->v9:
- Rebased.
- Adapted to request the tsc2007 gpio pinctrl outside of the tsc2007 bindings.

ChangeLog v7->v8:
- Added Shawn Guo in the cc list.
---
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
index b22841a..d4d4257 100644
--- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
+++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
@@ -42,6 +42,17 @@
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	tsc2007: tsc2007 at 49 {
+		compatible = "ti,tsc2007";
+		gpios = <&gpio4 0 1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <0x0 0x8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc2007_1>;
+		reg = <0x49>;
+		ti,x-plate-ohms = <180>;
+	};
 };
 
 &iomuxc {
-- 
1.7.9.5
