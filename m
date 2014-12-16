From: dianders@chromium.org (Doug Anderson)
Date: Mon, 15 Dec 2014 16:22:20 -0800
Subject: [PATCH v3 3/3] ARM: dts: Specify VMMC and VQMMC on rk3288-evb
In-Reply-To: <1418689340-29517-1-git-send-email-dianders@chromium.org>
References: <1418689340-29517-1-git-send-email-dianders@chromium.org>
Message-ID: <1418689340-29517-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specifying these rails should eventually let us do UHS.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v3: None
Changes in v2:
- Fix subject line

 arch/arm/boot/dts/rk3288-evb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 3e067dd..d660fe6 100644
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
