From: d-gerlach@ti.com (Dave Gerlach)
Date: Thu, 10 Jul 2014 21:55:45 -0500
Subject: [PATCH v4 07/11] ARM: dts: am33xx: Update wkup_m3 node
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1405047349-15101-8-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow interrupt for wkup_m3 to be set from DT, add regs for
IPC regs to allow pm code to communicate with wkup_m3, and add data
needed for mailbox channel.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
CC: Ohad Ben-Cohen <ohad@wizery.com>
CC: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6f8f7cf..fe0cff5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -736,10 +736,15 @@
 
 		wkup_m3: wkup_m3 at 44d00000 {
 			compatible = "ti,am3353-wkup-m3";
-			reg = <0x44d00000 0x4000	/* M3 UMEM */
-			       0x44d80000 0x2000>;	/* M3 DMEM */
+			reg = <0x44d00000 0x4000
+			       0x44d80000 0x2000
+			       0x44e11324 0x0024>;
+			reg-names = "m3_umem", "m3_dmem", "ipc_regs";
+			interrupts = <78>;
 			ti,hwmods = "wkup_m3";
 			ti,no-reset-on-init;
+			mbox-names = "wkup_m3";
+			mbox = <&mailbox &mbox_wkupm3>;
 		};
 
 		elm: elm at 48080000 {
-- 
1.9.0
