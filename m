From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Jan 2016 17:11:39 -0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Pass 'phy-reset-duration'
 property
Message-ID: <1451934700-28060-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As per the AR8031 datasheet:

"For a reliable power on reset, suggest to keep asserting the reset
low long enough (10ms) to ensure the clock is stable and clock-to-reset
1ms requirement is satisfied."

So do as suggested and keep the reset low for 10ms.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a6d445c..aebe1b2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -169,6 +169,7 @@
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-duration = <10>;
 	status = "okay";
 };
 
-- 
1.9.1
