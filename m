From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 16:34:34 +0100
Subject: [PATCH v2 1/4] ARM: dts: sun4i: Add simplefb node
In-Reply-To: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
References: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415979277-20861-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simplefb template node for u-boot to further fill and activate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 1ef7d57..cdb4708 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -27,6 +27,18 @@
 		serial7 = &uart7;
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer0-hdmi {
+			compatible = "simple-framebuffer";
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.0
