From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Nov 2016 14:43:39 +0800
Subject: [PATCH 2/2] ARM: dts: sun6i: hummingbird: Enable display engine again
In-Reply-To: <20161124064339.12615-1-wens@csie.org>
References: <20161124064339.12615-1-wens@csie.org>
Message-ID: <20161124064339.12615-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we disable the display engine by default, we need to re-enable
it for the Hummingbird A31, which already had its display pipeline
enabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index b168d6df2b30..83643bbd51dc 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -140,6 +140,10 @@
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.10.2
