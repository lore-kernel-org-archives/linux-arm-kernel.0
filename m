From: george.cherian@ti.com (George Cherian)
Date: Fri, 6 Jun 2014 11:47:34 +0530
Subject: [PATCH] ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for
 am43x-epos-evm
Message-ID: <1402035454-25676-1-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x EPOS evm use external clock for RMII interface.
Enable the same in DT. 

Signed-off-by: George Cherian <george.cherian@ti.com>
Reported-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 19f1f7e..90098f9 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -319,6 +319,10 @@
 	phy-mode = "rmii";
 };
 
+&phy_sel {
+	rmii-clock-ext;
+};
+
 &i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
1.8.3.1
