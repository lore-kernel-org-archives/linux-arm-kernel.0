From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:32:24 +0800
Subject: [PATCH v2 5/6] ARM: dts: rockchip: enable tsadc for rk3229-evb
In-Reply-To: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499243544-21726-1-git-send-email-frank.wang@rock-chips.com>
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
index a51ca01..cfcfe2a 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -192,6 +192,11 @@
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
