From: v1ron@mail.ru (Roman Volkov)
Date: Fri,  1 Jan 2016 16:38:12 +0300
Subject: [PATCH v3 RESEND 2/2] dts: vt8500: Fix errors in SDHC node for WM8505
In-Reply-To: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
References: <1451655492-2569-1-git-send-email-v1ron@mail.ru>
Message-ID: <1451655492-2569-3-git-send-email-v1ron@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Volkov <rvolkov@v1ros.org>

According to datasheet, the registers space of SDHC controller is 1Kb,
not '0x1000', the correct value should be '0x400'. Bracket interrupt
numbers individually per recommendations.

Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
---
 arch/arm/boot/dts/wm8505.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index a1a854b..e9ef539 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -281,8 +281,8 @@
 
 		sdhc at d800a000 {
 			compatible = "wm,wm8505-sdhc";
-			reg = <0xd800a000 0x1000>;
-			interrupts = <20 21>;
+			reg = <0xd800a000 0x400>;
+			interrupts = <20>, <21>;
 			clocks = <&clksdhc>;
 			bus-width = <4>;
 		};
-- 
2.3.1
