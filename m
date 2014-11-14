From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Nov 2014 16:34:36 +0100
Subject: [PATCH v2 3/4] ARM: dts: sun6i: Add simplefb node
In-Reply-To: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
References: <1415979277-20861-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1415979277-20861-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simplefb template node for u-boot to further fill and activate.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 543f895..04a5cb3 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -62,6 +62,16 @@
 		ethernet0 = &gmac;
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer0-hdmi {
+			compatible = "simple-framebuffer";
+			status = "disabled";
+		};
+	};
 
 	cpus {
 		enable-method = "allwinner,sun6i-a31";
-- 
2.1.0
