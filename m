From: denis@eukrea.com (Denis Carikli)
Date: Tue,  8 Apr 2014 18:22:42 +0200
Subject: [PATCH v11][ 2/2] ARM: dts: cpuimx51 Add touchscreen support.
In-Reply-To: <1396974162-16535-1-git-send-email-denis@eukrea.com>
References: <1396974162-16535-1-git-send-email-denis@eukrea.com>
Message-ID: <1396974162-16535-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v10->v11:
- Moved the Cc to git-send-email.

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
index 9b3acf6..6316426 100644
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
