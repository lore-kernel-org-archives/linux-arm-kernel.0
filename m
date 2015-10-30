From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Oct 2015 15:21:05 +0100
Subject: [PATCH 19/19] ARM: sun5i: chip: Enable the TV Encoder
In-Reply-To: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1446214865-3972-20-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TV encoder is used to drive VGA and composite display.

Enable it on the CHIP

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8.dtsi b/arch/arm/boot/dts/sun5i-r8.dtsi
index d69df3a73cbf..e39c903da864 100644
--- a/arch/arm/boot/dts/sun5i-r8.dtsi
+++ b/arch/arm/boot/dts/sun5i-r8.dtsi
@@ -86,4 +86,16 @@
 					     "ahb_mali400";
 		};
 	};
+
+	soc at 01c00000 {
+		tve: encoder at 01c0a000 {
+			compatible = "allwinner,sun4i-a10-tv-encoder";
+			reg = <0x01c0a000 0x1000>;
+			clocks = <&ahb_gates 34>;
+		};
+	};
+};
+
+&de {
+	allwinner,tv-encoder = <&tve>;
 };
-- 
2.6.2
