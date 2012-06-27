From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jun 2012 10:18:12 +0200
Subject: [PATCH 2/2] ARM: MXS: Add Crystalfontz CFA-10036 DTS
In-Reply-To: <1340785092-27035-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1340785092-27035-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1340785092-27035-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Brian Lily <brian@crystalfontz.com>
---
 arch/arm/boot/dts/cfa10036.dts |   43 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c   |    1 +
 2 files changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/cfa10036.dts

diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/cfa10036.dts
new file mode 100644
index 0000000..28b9326
--- /dev/null
+++ b/arch/arm/boot/dts/cfa10036.dts
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2012 Free Electrons
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx28.dtsi"
+
+/ {
+	model = "Crystalfontz CFA-10036 Board";
+	compatible = "crystalfontz,cfa10036", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a
+					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				bus-width = <4>;
+				status = "okay";
+			};
+		};
+
+		apbx at 80040000 {
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_b>;
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 8cac94b..7f4d6a9 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -97,6 +97,7 @@ static const char *imx23_dt_compat[] __initdata = {
 };
 
 static const char *imx28_dt_compat[] __initdata = {
+	"crystalfontz,cfa10036",
 	"fsl,imx28-evk",
 	"fsl,imx28",
 	NULL,
-- 
1.7.9.5
