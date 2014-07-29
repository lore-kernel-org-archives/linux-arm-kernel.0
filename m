From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 13:31:54 -0700
Subject: [PATCH 3/5] ARM: dts: Enable DDR50 mode on the eMMC
In-Reply-To: <1406665916-23396-1-git-send-email-dianders@chromium.org>
References: <1406665916-23396-1-git-send-email-dianders@chromium.org>
Message-ID: <1406665916-23396-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DDR50 mode now works on the rockchip driver, so enable it.

NOTE: if Addy spins (mmc: dw_mmc: add support for RK3288) before it
lands then we could squash this into my (ARM: dts: Enable emmc and
sdmmc on the rk3288-evb boards).

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index e44e34f..ec580fa 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -41,6 +41,7 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
-- 
2.0.0.526.g5318336
