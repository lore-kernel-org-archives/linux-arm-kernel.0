From: denis@eukrea.com (Denis Carikli)
Date: Tue, 24 Jun 2014 16:46:34 +0200
Subject: [PATCH v4 5/6] ARM: dts: imx25: mbimxsd25: Add touchscreen support.
In-Reply-To: <1403621195-9622-1-git-send-email-denis@eukrea.com>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Message-ID: <1403621195-9622-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v3->v4:
- None

Changelog v2->v3:
- Most of the non-board specific tsc and tscadc
  parts were moved to imx25.dtsi. So this patch
  was adapted to that.
- Thanks to a fix in the tsc driver, the 
  'fsl,pen-debounce = <100>;' is not necessary anymore.
---
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 68d0834..2f3bc3f 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -71,3 +71,11 @@
 	lcd-supply = <&reg_lcd_3v3>;
 	status = "okay";
 };
+
+&tsc {
+	status = "okay";
+};
+
+&tscadc {
+	status = "okay";
+};
-- 
1.7.9.5
