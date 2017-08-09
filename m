From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:42 +0800
Subject: [PATCH 01/10] arm64: dts: zx296718: add VGA device support
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds VGA device in zx296718.dtsi, so that boards with VGA connector
can enable the support by changing 'status' in board DTS file.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index 07368ab1e5e9..fdb1a57867ac 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -387,6 +387,16 @@
 					      "main_wclk", "aux_wclk";
 			};
 
+			vga: vga at 8000 {
+				compatible = "zte,zx296718-vga";
+				reg = <0x8000 0x1000>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&topcrm VGA_I2C_WCLK>;
+				clock-names = "i2c_wclk";
+				zte,vga-power-control = <&sysctrl 0x170 0xe0>;
+				status = "disabled";
+			};
+
 			hdmi: hdmi at c000 {
 				compatible = "zte,zx296718-hdmi";
 				reg = <0xc000 0x4000>;
-- 
1.9.1
