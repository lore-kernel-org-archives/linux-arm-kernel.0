From: eyalr@ti.com (Reizer, Eyal)
Date: Wed, 23 Dec 2015 11:40:07 +0000
Subject: [PATCH 2/3] ARM: dts: am335x-evm: add shared transport device tree
 bindings
In-Reply-To: <1450870253-8694-2-git-send-email-eyalr@ti.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <1450870253-8694-2-git-send-email-eyalr@ti.com>
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B23759A6B@DFRE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shared Shared Transport (ST) software enables BT and GPS protocols
or software components to interact with their respective cores over
single physical port.
Add the uart and enable pin device tree bindings

Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d9d00ab..b29c3f3 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -160,6 +160,18 @@
 			system-clock-frequency = <12000000>;
 		};
 	};
+
+	kim {
+		compatible = "kim";
+		nshutdown-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+		serial-device = <&uart1>;
+		flow_cntrl = <1>;
+		baud_rate = <3000000>;
+	};
+
+	btwilink {
+		compatible = "btwilink";
+	};
 };
 
 &am33xx_pinmux {
-- 
1.7.9.5
