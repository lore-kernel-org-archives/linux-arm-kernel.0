From: vigneshr@ti.com (Vignesh R)
Date: Thu, 23 Jul 2015 20:24:06 +0530
Subject: [PATCH v3 2/2] ARM: dts: am437x-gp-evm: Add wakeup interrupt source
 for pixcir_i2c_tsc
In-Reply-To: <1437663246-16049-1-git-send-email-vigneshr@ti.com>
References: <1437663246-16049-1-git-send-email-vigneshr@ti.com>
Message-ID: <1437663246-16049-3-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pixcir_i2c_tsc driver can now wakeup the system from lower power state
via pinctrl and IO daisy chain using generic wakeirq framwework. Add
optional wakeup irq entry to allow pixcir_i2c_tsc to wake system from
low power state.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v3:
 * Drop "irq" suffix from interrupt-names.

v2:
 * Add interrupt-names property.

 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..99209a137c63 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -503,6 +503,10 @@
 
 		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 
+		interrupts-extended = <&gpio3 22 GPIO_ACTIVE_HIGH>,
+				      <&am43xx_pinmux 0x264>;
+		interrupt-names = "tsc", "wakeup";
+
 		touchscreen-size-x = <1024>;
 		touchscreen-size-y = <600>;
 	};
-- 
2.4.5
