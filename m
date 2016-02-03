From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  3 Feb 2016 12:12:46 +0800
Subject: [PATCH 7/8] ARM: dts: rockchip: enable the tsadc for rk3228 evb
In-Reply-To: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
References: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1454472767-5767-8-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the tsadc for rk3228 evb board.

The rk3228 evb board uses the CRU to reset the chip since it hasn't the
PMIC to connect it, and TSHUT is low active on evb board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3228-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index e3898b8..c75cc41 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -61,6 +61,13 @@
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+
+	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
