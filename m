From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:19:05 -0200
Subject: [PATCH 11/13] ARM: dts: rv1108: Add internal timer support
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-11-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the internal timer peripheral on RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 7ef6d965871c..42566adadc83 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -291,6 +291,14 @@
 		};
 	};
 
+	timer: timer at 10350000 {
+		compatible = "rockchip,rv1108-timer", "rockchip,rk3288-timer";
+		reg = <0x10350000 0x20>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&xin24m>, <&cru PCLK_TIMER>;
+		clock-names = "timer", "pclk";
+	};
+
 	watchdog: wdt at 10360000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x10360000 0x100>;
-- 
2.19.1
