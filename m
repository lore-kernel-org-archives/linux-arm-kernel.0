From: dianders@chromium.org (Doug Anderson)
Date: Thu, 14 Feb 2013 16:21:17 -0800
Subject: [PATCH v2 3/3] ARM: dts: Add sbs-battery for exynos5250-snow
In-Reply-To: <1360887677-20758-1-git-send-email-dianders@chromium.org>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
Message-ID: <1360887677-20758-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have i2c-arbitrator in place on bus 4 we can add the
sbs-battery driver.  Future devices will be added onto bus 4 once
drivers are in good shape.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2: None

 arch/arm/boot/dts/exynos5250-snow.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index d2d4b48..2127386 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -51,6 +51,12 @@
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			battery: sbs-battery at b {
+				compatible = "sbs,sbs-battery";
+				reg = <0xb>;
+				sbs,poll-retry-count = <1>;
+			};
 		};
 	};
 
-- 
1.8.1
