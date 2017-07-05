From: biju.das@bp.renesas.com (Biju Das)
Date: Wed,  5 Jul 2017 11:57:35 +0100
Subject: [PATCH][RESEND] ARM: dts: iwg20d-q7: Add pinctl support for scif0
Message-ID: <1499252255-35283-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding pinctrl support for scif0 interface.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
v1-->v1-resend
This patch is been tested against linux-next tag next-20170704.
It is reposting,since the PFC depedencies now has been accepted.
https://www.spinics.net/lists/arm-kernel/msg592332.html

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 9b54783..497aec0 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -20,6 +20,16 @@
 	};
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data_d";
+		function = "scif0";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
-- 
1.9.1
