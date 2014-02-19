From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Wed, 19 Feb 2014 22:49:13 +1000
Subject: [PATCH v5 4/5] ARM: Kirkwood: Fix qnap vendor prefix
In-Reply-To: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
References: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the vendor prefix for qnap, which should be the stock ticker
symbol qnapsz.

Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt | 2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi                            | 4 ++--
 drivers/power/reset/qnap-poweroff.c                              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
index af25e77..aabda51 100644
--- a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -10,7 +10,7 @@ Synology NAS devices use a similar scheme, but a different baud rate,
 9600, and a different character, '1'.
 
 Required Properties:
-- compatible: Should be "qnap,power-off" or "synology,power-off"
+- compatible: Should be "qnapsz,power-off" or "synology,power-off"
 
 - reg: Address and length of the register set for UART1
 - clocks: tclk clock
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 911f3a8..0f0892a 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -1,6 +1,6 @@
 / {
 	model = "QNAP TS219 family";
-	compatible = "qnap,ts219", "marvell,kirkwood";
+	compatible = "qnapsz,ts219", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
@@ -46,7 +46,7 @@
 			pinctrl-names = "default";
 		};
 		poweroff at 12100 {
-			compatible = "qnap,power-off";
+			compatible = "qnapsz,power-off";
 			reg = <0x12000 0x100>;
 			clocks = <&gate_clk 7>;
 		};
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index a75db7f..d350ece 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -41,7 +41,7 @@ static const struct power_off_cfg synology_power_off_cfg = {
 };
 
 static const struct of_device_id qnap_power_off_of_match_table[] = {
-	{ .compatible = "qnap,power-off",
+	{ .compatible = "qnapsz,power-off",
 	  .data = &qnap_power_off_cfg,
 	},
 	{ .compatible = "synology,power-off",
-- 
1.8.3.2
