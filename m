From: b32955@freescale.com (Huang Shijie)
Date: Thu, 23 May 2013 16:16:15 +0800
Subject: [PATCH V2 3/6] ARM: dts: imx6qdl: add more information for WEIM
In-Reply-To: <1369296978-7669-1-git-send-email-b32955@freescale.com>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
Message-ID: <1369296978-7669-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock and compatible information for the weim.
Also adds the weim label.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 42e461c..f21d259 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -744,9 +744,11 @@
 				reg = <0x021b4000 0x4000>;
 			};
 
-			weim at 021b8000 {
+			weim: weim at 021b8000 {
+				compatible = "fsl,imx6q-weim";
 				reg = <0x021b8000 0x4000>;
 				interrupts = <0 14 0x04>;
+				clocks = <&clks 196>;
 			};
 
 			ocotp at 021bc000 {
-- 
1.7.1
