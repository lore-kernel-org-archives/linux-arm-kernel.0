From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 13:31:55 -0700
Subject: [PATCH 4/5] ARM: dts: Take the mmc slot node out of rk3288-evb
In-Reply-To: <1406665916-23396-1-git-send-email-dianders@chromium.org>
References: <1406665916-23396-1-git-send-email-dianders@chromium.org>
Message-ID: <1406665916-23396-5-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Jaehoon's (mmc: dw_mmc: replace "disable-wp" from slot's quirk to
host's quirk) the slot node is no longer used.  Remove it.

Note that if Jaehoon's patch lands before my (ARM: dts: Enable emmc
and sdmmc on the rk3288-evb boards) then this could be squashed into
the later.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index ec580fa..b69008f 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -41,17 +41,13 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	disable-wp;
 	mmc-ddr-1_8v;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
 	status = "okay";
-
-	slot at 0 {
-		reg = <0>;
-		disable-wp;
-	};
 };
 
 &sdmmc {
@@ -59,15 +55,11 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
+	disable-wp;			/* wp not hooked up */
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
-
-	slot at 0 {
-		reg = <0>;
-		disable-wp;		/* wp not hooked up */
-	};
 };
 
 &i2c0 {
-- 
2.0.0.526.g5318336
