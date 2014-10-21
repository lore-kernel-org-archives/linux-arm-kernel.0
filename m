From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Tue, 21 Oct 2014 11:15:10 -0500
Subject: [PATCHv3 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <1413908111-28165-1-git-send-email-dinguyen@opensource.altera.com>
References: <1413908111-28165-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1413908111-28165-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Without this patch, the booting the SOCFPGA platform would hang at the
SDMMC driver loading. The issue, debugged by Doug Anderson, turned out
to be that the GPIO bank used by the SD card-detect was not set to
status="okay".

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v3: Correctly degugged the issue to be a gpio node not having status="okay"
---
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index d7296a5..03a3745 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -37,6 +37,12 @@
 		 */
 		ethernet0 = &gmac1;
 	};
+
+	soc {
+		gpio at ff709000 {
+			status = "okay";
+		};
+	};
 };
 
 &gmac1 {
-- 
2.0.3
