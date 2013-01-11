From: dianders@chromium.org (Doug Anderson)
Date: Fri, 11 Jan 2013 09:03:51 -0800
Subject: [PATCH v4 2/5] ARM: dts: Add disable-wp for sd card slot on smdk5250
In-Reply-To: <1357923834-31641-1-git-send-email-dianders@chromium.org>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
 <1357923834-31641-1-git-send-email-dianders@chromium.org>
Message-ID: <1357923834-31641-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next change will remove the code from the dw_mmc-exynos that added
the DW_MCI_QUIRK_NO_WRITE_PROTECT.  Keep existing functionality of
having no write protect pin on smdk5250 by adding the disable-wp
property.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes in v4: None
Changes in v3:
- New for this version of the patch series.

 arch/arm/boot/dts/exynos5250-smdk5250.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 942d576..75b9d83 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -146,6 +146,7 @@
 			reg = <0>;
 			bus-width = <4>;
 			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
+			disable-wp;
 			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
 				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
 				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
-- 
1.7.7.3
