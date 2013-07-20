From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 11:17:57 +0400
Subject: [PATCH 4/6] ARM: dts: i.MX27: Increase "clock-latency" value
In-Reply-To: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
References: <1374304679-27338-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374304679-27338-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX27 CPU can be clocked with a 32 kHz quartz, and not just 32768 Hz,
so increase "clock-latency" value, which will ensure that we use two
clock cycles on frequency change.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index a8e0c7e..c06df85 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -61,7 +61,7 @@
 				266000 1300000
 				399000 1450000
 			>;
-			clock-latency = <61036>; /* two CLK32 periods */
+			clock-latency = <62500>;
 			clocks = <&clks 18>;
 			clock-names = "cpu";
 			voltage-tolerance = <5>;
-- 
1.8.1.5
