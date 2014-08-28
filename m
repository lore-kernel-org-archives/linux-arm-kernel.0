From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 28 Aug 2014 09:40:17 +0800
Subject: [RESEND PATCH] ARM: dts: make arch-timer always on in rk3288 soc
Message-ID: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need use the hrtimer, which need the arch-timer to be 'always-on'

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..698e6ea 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -76,6 +76,7 @@
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clock-frequency = <24000000>;
+		always-on;
 	};
 
 	i2c1: i2c at ff140000 {
-- 
1.9.1
