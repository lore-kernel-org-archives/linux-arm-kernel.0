From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  2 Oct 2018 10:43:40 +0200
Subject: [PATCH 1/2] arm64: dts: meson-axg: s400: add missing emmc pwrseq
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com>
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Message-ID: <20181002084341.5487-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

eMMC pwrseq is defined in the s400 dts but not used in the emmc node.
This is probably just a copy/paste error

Fixes: 221cf34bac54 ("ARM64: dts: meson-axg: enable the eMMC controller")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d6467ac333ec..166ab598395e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -493,6 +493,8 @@
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 
+	mmc-pwrseq = <&emmc_pwrseq>;
+
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 };
-- 
2.17.1
