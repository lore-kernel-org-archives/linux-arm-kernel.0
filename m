From: frank.wang@rock-chips.com (Frank Wang)
Date: Tue,  4 Jul 2017 16:14:34 +0800
Subject: [PATCH 5/6] ARM: dts: rockchip: enable tsadc for rk3229-evb
In-Reply-To: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
References: <1499155967-26090-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499156074-26355-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the tsadc for rk3229-evb board.

The rk3229 evb board uses the CRU to reset the chip since it has not
the PMIC to connect it, and TSHUT is low active on evb board.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index bae0dbf..43c3ad2 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -181,6 +181,11 @@
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.0.0
