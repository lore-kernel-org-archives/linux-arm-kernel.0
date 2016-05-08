From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:06:04 +0200
Subject: [PATCH v2 19/22] ARM: dts: exynos: MCT is not an interrupt controller
 and extend length of iomap
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-20-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multi-Core Timer generates interrupts but it is not really an interrupt
controller so remove the "interrupt-controller" and "interrupt-cells"
properties. Additionally extend the length of mapped memory to cover all
registers (last SFR is at 0x0A40).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 3114cd6fb5d1..ac39e3b8b0e1 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -267,9 +267,7 @@
 
 		mct: mct at 101C0000 {
 			compatible = "samsung,exynos4210-mct";
-			reg = <0x101C0000 0x800>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
+			reg = <0x101C0000 0xB00>;
 			interrupt-parent = <&mct_map>;
 			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
 					<8>, <9>, <10>, <11>;
-- 
2.5.0
