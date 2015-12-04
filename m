From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Dec 2015 19:48:55 +0000
Subject: [PATCH v2 14/12] ARM: dts: enable GPU for SolidRun's Cubox
In-Reply-To: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
References: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <E1a4wLf-0004Vo-81@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the GPU for SolidRun's Cubox.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove-cubox.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index e6fa251e17b9..af3cb633135f 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -62,6 +62,10 @@
 		pinctrl-0 = <&pmx_gpio_19>;
 		pinctrl-names = "default";
 	};
+
+	gpu-subsystem {
+		status = "okay";
+	};
 };
 
 &uart0 { status = "okay"; };
@@ -74,6 +78,10 @@
 	reg = <1>;
 };
 
+&gpu {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
-- 
2.1.0
