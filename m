From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:29:05 +0200
Subject: [PATCH 3/4] ARM: dove: add GPIO IR receiver node to SolidRun CuBox
In-Reply-To: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1375100946-28521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1375100946-28521-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a node for the IR receiver connected to a GPIO pin on the
SolidRun CuBox.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove-cubox.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 525fb45..022646e 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -55,6 +55,13 @@
 			clock-frequency = <25000000>;
 		};
 	};
+
+	ir_recv: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio0 19 1>;
+		pinctrl-0 = <&pmx_gpio_19>;
+		pinctrl-names = "default";
+	};
 };
 
 &uart0 { status = "okay"; };
-- 
1.7.10.4
