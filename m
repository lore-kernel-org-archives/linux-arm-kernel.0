From: balbi@ti.com (Felipe Balbi)
Date: Fri, 26 Dec 2014 13:28:23 -0600
Subject: [PATCH 4/5] arm: boot: dts: am437x-sk: add power button binding
In-Reply-To: <1419622104-25812-1-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
Message-ID: <1419622104-25812-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let this board report KEY_POWER so upper layers
can decide what to do when power button is pressed.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 53bbfc9..c53840c 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -386,6 +386,11 @@
 			regulator-always-on;
 		};
 
+		power-button {
+			compatible = "ti,tps65218-pwrbutton";
+			status = "okay";
+			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+		};
 	};
 
 	at24 at 50 {
-- 
2.2.0
