From: wxt@rock-chips.com (Caesar Wang)
Date: Sun,  8 Nov 2015 17:26:08 +0800
Subject: [PATCH v3 10/10] arm64: dts: Enable the Thermal on R88 board
In-Reply-To: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
References: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1446974768-25795-11-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enable the TS-ADC.

When a thermal temperature is invoked use the CRU to reset the chip
on R88 board. TSHUT is low active on this board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>

---

Changes in v3: None
Changes in v2: None
Changes in v1: None

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
