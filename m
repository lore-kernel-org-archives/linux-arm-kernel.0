From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Aug 2015 16:44:32 +0200
Subject: [PATCH 1/6] ARM: dts: sun5i: Add simplefb node for tvencoder output
In-Reply-To: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1439563477-12295-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simplefb node for tvencoder / composite-video output, such as found
on the Auxtek-T003 and the CHIP.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index a6d55f0..3e47b3d 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -77,6 +77,15 @@
 			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
 			status = "disabled";
 		};
+
+		framebuffer at 2 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0-tve0";
+			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.4.3
