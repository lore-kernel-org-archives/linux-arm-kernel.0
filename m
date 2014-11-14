From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 16:34:35 +0100
Subject: [PATCH v2 2/4] ARM: dts: sun5i: Add simplefb node
In-Reply-To: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
References: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415979277-20861-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simplefb template node for u-boot to further fill and activate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 7089284..aee7f25 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -24,6 +24,18 @@
 		serial3 = &uart3;
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
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
-- 
2.1.0
