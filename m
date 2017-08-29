From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Aug 2017 13:52:51 +0530
Subject: [PATCH] ARM: dts: da850-evm: add serial and ethernet aliases
Message-ID: <1dd5c92749644601bc23ebd4fb92c5fb30b51d20.1503994832.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases for serial and ethernet nodes. Serial
aliases help keep order of tty nodes fixed and
ethernet alias is used by bootloader to setup mac
address correctly.

Reported-by: Adam Ford <aford173@gmail.com>
Fixes: dd7deaf218bf ("ARM: davinci: da850: add DT node for ethernet")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 67e72bc72e80..c75507922f7d 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -15,6 +15,13 @@
 	compatible = "ti,da850-evm", "ti,da850";
 	model = "DA850/AM1808/OMAP-L138 EVM";
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		ethernet0 = &eth0;
+	};
+
 	soc at 1c00000 {
 		pmx_core: pinmux at 14120 {
 			status = "okay";
-- 
2.9.0
