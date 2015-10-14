From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Oct 2015 00:32:21 +0800
Subject: [PATCH 5/6] ARM: dts: sun8i: Add NMI interrupt controller node
In-Reply-To: <1444840342-9233-1-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
Message-ID: <1444840342-9233-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NMI interrupt controller is in charge of the NMI pin exposed by
the SoC to the PMIC. The PMIC signals interrupts through this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 828aaf52c342..a1e3acd325f4 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -579,6 +579,14 @@
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		nmi_intc: interrupt-controller at 01f00c0c {
+			compatible = "allwinner,sun6i-a31-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c0c 0x38>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		prcm at 01f01400 {
 			compatible = "allwinner,sun8i-a23-prcm";
 			reg = <0x01f01400 0x200>;
-- 
2.6.1
