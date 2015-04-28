From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 28 Apr 2015 13:59:41 +0300
Subject: [PATCH 1/4] ARM: digicolor: enable CX92755 on-chip RTC device
In-Reply-To: <cover.1430217994.git.baruch@tkos.co.il>
References: <cover.1430217994.git.baruch@tkos.co.il>
Message-ID: <cd1fa7f2985a0816cadb8107739abd7be7c140ca.1430217994.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index 490c08075e67..a2f5ffe1e8a8 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -82,6 +82,12 @@
 		clocks = <&main_clk>;
 	};
 
+	rtc at f0000c30 {
+		compatible = "cnxt,cx92755-rtc";
+		reg = <0xf0000c30 0x18>;
+		interrupts = <25>;
+	};
+
 	uc_regs: syscon at f00003a0 {
 		compatible = "cnxt,cx92755-uc", "syscon";
 		reg = <0xf00003a0 0x10>;
-- 
2.1.4
