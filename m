From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 26 Nov 2014 15:38:10 -0600
Subject: [RFC PATCH 3/3] ARM: dts: am33xx: Add wkup_m3_ipc node
In-Reply-To: <cover.1417029919.git.d-gerlach@ti.com>
References: <cover.1417029919.git.d-gerlach@ti.com>
Message-ID: <4981daf0740253def2cfcf11a2994526191d9f32.1417029919.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wkup_m3_ipc node for wkup_m3_ipc driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 41659df..b86d8c0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -848,6 +848,15 @@
 			reg = <0x48310000 0x2000>;
 			interrupts = <111>;
 		};
+
+		wkup_m3_ipc: wkup_m3_ipc at 44e11324 {
+			compatible = "ti,am3353-wkup-m3-ipc";
+			reg = <0x44e11324 0x0024>;
+			reg-names = "ipc_regs";
+			interrupts = <78>;
+			ti,rproc = <&wkup_m3>;
+			mboxes = <&mailbox &mbox_wkupm3>;
+		};
 	};
 };
 
-- 
2.1.0
