From: wxt@rock-chips.com (Caesar Wang)
Date: Mon, 21 Sep 2015 12:16:11 +0800
Subject: [PATCH 5/5] arm64: dts: Enable the Thermal on R88 board
In-Reply-To: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1442808971-2619-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enable the TS-ADC.

When a thermal temperature is invoked use the CRU to reset the chip
on R88 board. TSHUT is low active on this board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 401a812..7684426a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -336,6 +336,12 @@
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+	status = "okay";
+}
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
