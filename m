From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 10 Sep 2018 13:30:29 +0200
Subject: [PATCH 2/4] DT: marvell,mmp2: add clock to the timer
In-Reply-To: <20180910113031.42634-1-lkundrak@v3.sk>
References: <20180910113031.42634-1-lkundrak@v3.sk>
Message-ID: <20180910113031.42634-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..58e0098a007d 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -130,6 +130,7 @@
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
 				interrupts = <13>;
+				clocks = <&soc_clocks MMP2_CLK_TIMER>;
 			};
 
 			uart1: uart at d4030000 {
-- 
2.17.1
