From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Dec 2014 12:58:05 -0800
Subject: [PATCH 4/4] ARK: dts: Specify VMMC and VQMMC on rk3288-evb
In-Reply-To: <1418245085-9754-1-git-send-email-dianders@chromium.org>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
Message-ID: <1418245085-9754-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying these rails should eventually let us do UHS.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 6194d67..1956a23 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -114,6 +114,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vccio_sd>;
 };
 
 &i2c0 {
-- 
2.2.0.rc0.207.ga3a616c
