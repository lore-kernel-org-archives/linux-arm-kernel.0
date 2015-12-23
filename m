From: eyalr@ti.com (Reizer, Eyal)
Date: Wed, 23 Dec 2015 11:41:01 +0000
Subject: [PATCH 3/3] ARM: dts: am437x-gp-evm: add shared transport device
 tree bindings
In-Reply-To: <1450870253-8694-3-git-send-email-eyalr@ti.com>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <1450870253-8694-3-git-send-email-eyalr@ti.com>
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B23759A73@DFRE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shared Shared Transport (ST) software enables BT and GPS protocols
or software components to interact with their respective cores over
single physical port.
Add the uart and enable pin device tree bindings

Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index d2450ab..9156c3c 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -145,6 +145,18 @@
 			system-clock-frequency = <12000000>;
 		};
 	};
+
+	kim {
+		compatible = "kim";
+		nshutdown-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+		serial-device = <&uart3>;
+		flow_cntrl = <1>;
+		baud_rate = <3000000>;
+	};
+
+	btwilink {
+		 compatible = "btwilink";
+	};
 };
 
 &am43xx_pinmux {
-- 
1.7.9.5
