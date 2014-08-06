From: dianders@chromium.org (Doug Anderson)
Date: Wed,  6 Aug 2014 10:09:43 -0700
Subject: [PATCH v3 3/4] ARM: dts: Take the mmc slot node out of rk3288-evb
In-Reply-To: <1407344984-14176-1-git-send-email-dianders@chromium.org>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
Message-ID: <1407344984-14176-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Jaehoon's (mmc: dw_mmc: Slot quirk "disable-wp" is deprecated) the
slot node is no longer used.  Remove it.

Note that if Jaehoon's patch lands before my (ARM: dts: Enable emmc
and sdmmc on the rk3288-evb boards) then this could be squashed into
the later.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v3: None
Changes in v2:
- Refer to the new title of Jaehoon's patch

 arch/arm/boot/dts/rk3288-evb.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index c2cf72f..ebce49a 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -53,16 +53,12 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	disable-wp;
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
@@ -70,15 +66,11 @@
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
