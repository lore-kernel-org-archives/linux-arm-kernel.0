From: rodrigo@tjader.xyz (=?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?=)
Date: Wed, 19 Sep 2018 11:19:36 -0300
Subject: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix ethernet
Message-ID: <20180919141938.18791-1-rodrigo@tjader.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without "allwinner,tx-delay-ps = <600>;" on the DTP it can receive packets
but not send.

Signed-off-by: Rodrigo Exterck?tter Tj?der <rodrigo@tjader.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 5245de3a1f35..75a435b9509b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -90,6 +90,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdc1>;
+	allwinner,tx-delay-ps = <600>;
 	status = "okay";
 };
 
-- 
2.18.0
