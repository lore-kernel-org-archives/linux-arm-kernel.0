From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 27 Sep 2013 11:12:41 -0300
Subject: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: Provide phy-reset-gpios
In-Reply-To: <1380291162-17099-1-git-send-email-festevam@gmail.com>
References: <1380291162-17099-1-git-send-email-festevam@gmail.com>
Message-ID: <1380291162-17099-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

GPIO1_25 is used to reset the ethernet phy.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 64e454b..2035d66 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -108,6 +108,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
 	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 25 0>;
 	status = "okay";
 };
 
@@ -172,6 +173,7 @@
 				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x80000000
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
 			>;
 		};
 	};
-- 
1.8.1.2
