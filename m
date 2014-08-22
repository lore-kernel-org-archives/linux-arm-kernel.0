From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 09:03:55 -0500
Subject: [PATCH 6/6] ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable
In-Reply-To: <1408716235-26164-1-git-send-email-nm@ti.com>
References: <1408716235-26164-1-git-send-email-nm@ti.com>
Message-ID: <1408716235-26164-7-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark rxd as wakeupcapable for 115200n8 no hardware-flow control
configuration. If h/w flow control is being used, then rts/cts
appropriately should be used.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 50f8022..a329177 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -303,6 +303,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
+	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH
+			       &dra7_pmx_core 0x3e0>;
 };
 
 &uart2 {
-- 
1.7.9.5
