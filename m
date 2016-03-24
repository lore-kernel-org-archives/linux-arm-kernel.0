From: plaes@plaes.org (Priit Laes)
Date: Thu, 24 Mar 2016 21:52:17 +0200
Subject: [PATCH v2 2/2] ARM: sun7i: dt: Enable dram gate 5 (tve0 clock) for
 simplefb TV output
In-Reply-To: <1458849137-3883-1-git-send-email-plaes@plaes.org>
References: <1458849137-3883-1-git-send-email-plaes@plaes.org>
Message-ID: <1458849137-3883-3-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems like dram_gate 5 was forgotten when DRAM gating driver was added.

Add it.

Cc: stable at vger.kernel.org
Fixes: 0b4bf5a5200b (ARM: dts: sun7i: Add DRAM gates)
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0940a78..ee4e8e7 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -85,8 +85,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>, <&dram_gates 26>;
+			clocks = <&pll5 1>,
+				 <&ahb_gates 34>, <&ahb_gates 36>, <&ahb_gates 44>,
+				 <&dram_gates 5>, <&dram_gates 26>;
 			status = "disabled";
 		};
 	};
-- 
2.5.0
