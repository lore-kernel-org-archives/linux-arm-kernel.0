From: dianders@chromium.org (Doug Anderson)
Date: Tue, 16 Apr 2013 09:29:02 -0700
Subject: [PATCH v6 3/3] ARM: dts: Add sbs-battery for exynos5250-snow
In-Reply-To: <1366129742-16048-1-git-send-email-dianders@chromium.org>
References: <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <1366129742-16048-1-git-send-email-dianders@chromium.org>
Message-ID: <1366129742-16048-3-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have i2c-arbitrator in place on bus 4 we can add the
sbs-battery driver.  Future devices will be added onto bus 4 once
drivers are in good shape.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/exynos5250-snow.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index fa85f58..c115143 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -66,6 +66,12 @@
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
1.8.1.3
