From: romain.perier@collabora.com (Romain Perier)
Date: Mon,  4 Sep 2017 10:51:19 +0200
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add efuse for RK3368 SoCs
In-Reply-To: <20170904085119.25981-1-romain.perier@collabora.com>
References: <20170904085119.25981-1-romain.perier@collabora.com>
Message-ID: <20170904085119.25981-5-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the definition for eFuse that is found on RK3368 SoCs with the
corresponding data cells.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 3039c2da533e..cca2ce1705b3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -569,6 +569,20 @@
 		};
 	};
 
+	efuse: efuse at ffb00000 {
+		compatible = "rockchip,rk3368-efuse";
+		reg = <0x0 0xffb00000 0x0 0x20>;
+		clocks = <&cru PCLK_EFUSE_256>;
+		clock-names = "pclk_efuse";
+
+		cpu_leakage: cpu-leakage at 17 {
+			reg = <0x17 0x1>;
+		};
+		temp_adjust: temp-adjust at 1f {
+			reg = <0x1f 0x1>;
+		};
+	};
+
 	tsadc: tsadc at ff280000 {
 		compatible = "rockchip,rk3368-tsadc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
2.11.0
