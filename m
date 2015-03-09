From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  9 Mar 2015 17:40:35 +0100
Subject: [PATCH 2/3] ARM: dts: hummingboard/cubox-i: enable front LED PWM
 explicitly
In-Reply-To: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
References: <1425919236-6664-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1425919236-6664-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All PWM users should explicitly enable the used PWMs in their device tree
so they can be disabled by default in imx6qdl.dtsi.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 6a524ca..6c9f5e9 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -173,6 +173,10 @@
 	};
 };
 
+&pwm1 {
+	status = "okay";
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_spdif>;
-- 
2.1.4
