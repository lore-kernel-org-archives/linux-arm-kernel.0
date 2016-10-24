From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 25 Oct 2016 01:08:31 +0800
Subject: [PATCH] ARM: dts: sun8i: fix the pinmux for UART1
Message-ID: <20161024170831.38819-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the patch is applied, the allwinner,driver and allwinner,pull
properties are removed.

Although they're described to be optional in the devicetree binding,
without them, the pinmux cannot be initialized, and the uart cannot
be used.

Add them back to fix the problem, and makes the bluetooth on iNet D978
Rev2 board work.

Fixes: 82eec384249f (ARM: dts: sun8i: add pinmux for UART1 at PG)

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---

This patch is targeted on 4.9.

 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 48fc24f..300a1bd 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -282,11 +282,15 @@
 			uart1_pins_a: uart1 at 0 {
 				allwinner,pins = "PG6", "PG7";
 				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			uart1_pins_cts_rts_a: uart1-cts-rts at 0 {
 				allwinner,pins = "PG8", "PG9";
 				allwinner,function = "uart1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			mmc0_pins_a: mmc0 at 0 {
-- 
2.10.1
