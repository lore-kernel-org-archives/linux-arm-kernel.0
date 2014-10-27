From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Mon, 27 Oct 2014 10:39:48 +0800
Subject: [PATCH v14 5/5] ARM: dts: enable Thermal on rk3288-evb board
In-Reply-To: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
References: <1414377588-2237-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1414377588-2237-6-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when a thermal temperature over TSHUT.Default to via
CRU reset the entire chip on rk3288-evb Board,
TSHUT is low active on rk3288-evb board.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index cb83cea..fb70523 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -148,6 +148,12 @@
 	status = "okay";
 };
 
+&tsadc {
+	tsadc-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	tsadc-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+	status = "okay";
+};
+
 &pinctrl {
 	backlight {
 		bl_en: bl-en {
-- 
1.9.1
