From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 27 Aug 2015 16:49:09 +0800
Subject: [PATCH 4/5] ARM: dts: Add broken-no-flushp quirk for rk3xxx platform
In-Reply-To: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1440665349-31729-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pl330 integrated in rk3xxx platform doesn't support
DMAFLUSHP function. So we add broken-no-flushp quirk
for it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olofj@google.com>
---

 arch/arm/boot/dts/rk3xxx.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index a2ae9f3..8bf9c71 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -79,6 +79,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			broken-no-flushp;
 		};
 
 		dmac1_ns: dma-controller at 2001c000 {
@@ -89,6 +90,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			broken-no-flushp;
 			status = "disabled";
 		};
 
@@ -100,6 +102,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA2>;
 			clock-names = "apb_pclk";
+			broken-no-flushp;
 		};
 	};
 
-- 
2.3.7
