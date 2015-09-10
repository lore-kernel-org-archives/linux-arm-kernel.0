From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 10 Sep 2015 14:21:44 -0500
Subject: [PATCH v3 4/8] ARM: dts: imx: imx7d-sbd add iomuxc-lpsr hoggrp-2 pads
In-Reply-To: <1441912908-21946-1-git-send-email-aalonso@freescale.com>
References: <1441912908-21946-1-git-send-email-aalonso@freescale.com>
Message-ID: <1441912908-21946-4-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx7d-sdb iomuxc-lpsr hoggrp-2 default pads settings

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Resend
Changes for V3: Resend

 arch/arm/boot/dts/imx7d-sdb.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index fdd1d7c..63af4ea 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -406,3 +406,18 @@
 
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_2>;
+
+	imx7d-sdb {
+		pinctrl_hog_2: hoggrp-2 {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO05__GPIO1_IO5    0x14
+				MX7D_PAD_GPIO1_IO07__GPIO1_IO7    0x59
+				MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_B 0x74
+			>;
+		};
+	};
+};
-- 
2.1.4
