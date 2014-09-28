From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Sun, 28 Sep 2014 18:38:13 +0800
Subject: [PATCH v7 5/5] ARM: dts: enable Thermal on rk3288-evb board
In-Reply-To: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
References: <1411900693-30484-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1411900693-30484-6-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when a thermal shutdown at 125C.Via GPIO give PMIC,
Reset the entire chip.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 2964370..a6872aa 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -101,6 +101,11 @@
 	status = "okay";
 };
 
+&tsadc {
+	reset-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &pinctrl {
 	buttons {
 		pwrbtn: pwrbtn {
-- 
1.9.1
