From: Priit.Laes@icefire.ee (Priit Laes)
Date: Thu, 24 Mar 2016 20:08:39 +0200
Subject: [PATCH 1/2] ARM: sun4i: dt: Enable dram gate 5 (tve0 clock) for
 simplefb TV output
In-Reply-To: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
References: <1458842920-30854-1-git-send-email-Priit.Laes@icefire.ee>
Message-ID: <1458842920-30854-2-git-send-email-Priit.Laes@icefire.ee>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Priit Laes <plaes@plaes.org>

Seems like dram_gate 5 was forgotten when DRAM gate driver was added.

Enable it.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 2c8f5e6..bf70d0a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -96,7 +96,7 @@
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
 			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
 				 <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&dram_gates 25>, <&dram_gates 26>;
+				 <&dram_gates 5>, <&dram_gates 25>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
-- 
2.5.0
