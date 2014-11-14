From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 16:34:37 +0100
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add simplefb node
In-Reply-To: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
References: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415979277-20861-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simplefb template node for u-boot to further fill and activate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 81d4e55..58c1573 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -64,6 +64,18 @@
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
