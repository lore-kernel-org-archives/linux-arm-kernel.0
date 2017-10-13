From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Fri, 13 Oct 2017 23:03:32 +0530
Subject: [PATCH] ARM: dts: rockchip: Enable thermal on rk3288-vyasa board
Message-ID: <1507916012-3980-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Enable thermal on rk3288-vyasa board, TSHUT is high active.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-vyasa.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 932311c..3546eb8 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -302,6 +302,12 @@
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.7.4
