From: b32955@freescale.com (Huang Shijie)
Date: Tue, 16 Oct 2012 14:03:06 +0800
Subject: [PATCH 3/3] ARM: dts: enable dma support for auart0 in mx28
In-Reply-To: <1350367386-7742-1-git-send-email-b32955@freescale.com>
References: <1350367386-7742-1-git-send-email-b32955@freescale.com>
Message-ID: <1350367386-7742-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable the dma support for auart0 in mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6ed9215..738e023 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -798,6 +798,8 @@
 				compatible = "fsl,imx28-auart";
 				reg = <0x8006a000 0x2000>;
 				interrupts = <112 70 71>;
+				fsl,auart-dma-channel = <8 9>;
+				fsl,auart-enable-dma;
 				clocks = <&clks 45>;
 				status = "disabled";
 			};
-- 
1.7.0.4
