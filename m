From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:46 -0500
Subject: [PATCH 3/5] ARM: dts: k2g: Add pinctrl support
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <1461766308-27669-4-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vitaly Andrianov <vitalya@ti.com>

Add pinctrl support.

Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/keystone-k2g.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 7ff2796..b99e879 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -75,6 +75,13 @@
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
+		k2g_pinctrl: pinmux at 02621000 {
+			compatible = "pinctrl-single";
+			reg = <0x02621000 0x410>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <0x001b0007>;
+		};
+
 		uart0: serial at 02530c00 {
 			compatible = "ns16550a";
 			current-speed = <115200>;
-- 
2.7.0
