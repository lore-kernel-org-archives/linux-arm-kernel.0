From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 17:56:20 +0800
Subject: [PATCH 5/6] arm64: dts: meson-axg: complete the pinctrl info for
 UART_AO_A
In-Reply-To: <20180105095621.196472-1-yixun.lan@amlogic.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
Message-ID: <20180105095621.196472-6-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explictly request the pinctrl info for the UART_AO_A controller,
otherwise we my rely on bootloader for the initialization.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 70eca1f8736a..2b79be356996 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -19,4 +19,6 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
-- 
2.15.1
