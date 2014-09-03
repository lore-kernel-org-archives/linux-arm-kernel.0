From: dianders@chromium.org (Doug Anderson)
Date: Wed,  3 Sep 2014 16:05:23 -0700
Subject: [PATCH v2] ARM: dts: Add mshc aliases for rk3288
Message-ID: <1409785523-12209-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's convenient (and less confusing to people reading logs) if the
eMMC port on rk3288 is consistenly marked with mmc0 and the sdmmc port
on rk3288 is consistently marked with mmc1.  Add the appropriate
aliases.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v2:
- Use mshc aliases now
- Adds sdio0/1 aliases since those are in the dts.

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5f866e0..2c5d01f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -29,6 +29,10 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		mshc0 = &emmc;
+		mshc1 = &sdmmc;
+		mshc2 = &sdio0;
+		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.1.0.rc2.206.gedb03e5
