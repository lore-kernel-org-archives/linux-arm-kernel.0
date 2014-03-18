From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 18 Mar 2014 15:18:17 +0200
Subject: [PATCH] ARM: dts: keystone: Fix domain register range for clkfftc1
Message-ID: <1395148697-22481-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The domain register range for clkfftc1 has to be 0x0235004c
instead of 0x023504c0.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 arch/arm/boot/dts/k2hk-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/k2hk-clocks.dtsi b/arch/arm/boot/dts/k2hk-clocks.dtsi
index 8855b1f..96e6536 100644
--- a/arch/arm/boot/dts/k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/k2hk-clocks.dtsi
@@ -209,7 +209,7 @@ clocks {
 		compatible = "ti,keystone,psc-clock";
 		clocks = <&chipclk13>;
 		clock-output-names = "fftc-1";
-		reg = <0x02350074 0xb00>, <0x023504c0 0x400>;
+		reg = <0x02350074 0xb00>, <0x0235004c 0x400>;
 		reg-names = "control", "domain";
 		domain-id = <19>;
 	};
-- 
1.8.3.2
