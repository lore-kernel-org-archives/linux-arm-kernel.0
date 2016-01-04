From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Jan 2016 17:11:40 -0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-microsom-ar8035: Adjust Ethernet PHY
 reset duration
In-Reply-To: <1451934700-28060-1-git-send-email-festevam@gmail.com>
References: <1451934700-28060-1-git-send-email-festevam@gmail.com>
Message-ID: <1451934700-28060-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

As per the AR8035 datasheet:

"For a reliable power on reset, suggest to keep asserting the reset
low long enough (10ms) to ensure the clock is stable and clock-to-reset
1ms requirement is satisfied."

So do as suggested and keep the reset low for 10ms.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index 469ef58..d187177 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -45,7 +45,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
 	phy-mode = "rgmii";
-	phy-reset-duration = <2>;
+	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio4 15 0>;
 	status = "okay";
 };
-- 
1.9.1
