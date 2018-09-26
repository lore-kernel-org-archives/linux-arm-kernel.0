From: rodrigo@tjader.xyz (=?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?=)
Date: Wed, 26 Sep 2018 19:48:24 +0000
Subject: [PATCH v2] arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
In-Reply-To: <20180926170545.ogcmt36ff7jmqxkl@flea>
References: <20180926170545.ogcmt36ff7jmqxkl@flea>
Message-ID: <20180926194824.8832-1-rodrigo@tjader.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PHY found on the A64-OLinuXino requires a TX delay in order to
operate properly. Olimex uses a 600ps second delay in their BSP, and
that has been found to work, so let's use that value in the current
DT.

Signed-off-by: Rodrigo Exterck?tter Tj?der <rodrigo@tjader.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 6ef3dd4c2389..f7a4bccaa5d4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -105,6 +105,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdc1>;
+	allwinner,tx-delay-ps = <600>;
 	status = "okay";
 };
 
-- 
2.11.0
