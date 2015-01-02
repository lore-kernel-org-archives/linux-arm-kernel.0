From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 2 Jan 2015 14:00:17 -0600
Subject: [PATCH 3/3] ARM: dts: am33xx: Add wkup_m3_ipc node
In-Reply-To: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1420228817-41310-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add wkup_m3_ipc node for wkup_m3_ipc driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd3705..1ebb230 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -863,6 +863,15 @@
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
