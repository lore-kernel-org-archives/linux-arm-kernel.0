From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 28 Nov 2018 18:53:08 +0100
Subject: [PATCH v4 04/20] DT: marvell,mmp2: add clock to the timer
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
Message-ID: <20181128175324.163202-5-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer needs the timer clock to be enabled, otherwise it stops
ticking.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/boot/dts/mmp2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index f2a18779de7c..4743a1288280 100644
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
2.19.1
