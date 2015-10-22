From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Oct 2015 12:30:26 +0800
Subject: [PATCH] ARM: sun4i: Enable cubieboard audio codec
Message-ID: <1445488226-19173-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cubieboard uses the internal codec to output sound to its mini-jack.
Enable it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Maxime,

This patch applies on top of your audio codec DT series.
Tested with 44.1 kHz and 48 kHz mp3 files using mpg123.

ChenYu

---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 046a84d9719d..710e2ef516a8 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -83,6 +83,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.6.1
