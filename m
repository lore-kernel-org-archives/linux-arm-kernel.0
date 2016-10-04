From: briannorris@chromium.org (Brian Norris)
Date: Tue,  4 Oct 2016 11:12:10 -0700
Subject: [PATCH v2 2/2] arm64: dts: rockchip: arch counter doesn't tick in
 system suspend
In-Reply-To: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
References: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
Message-ID: <1475604730-140264-2-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "arm,no-tick-in-suspend" property was introduced to note
implementations where the system counter does not quite follow the ARM
specification that it "must be implemented in an always-on power
domain".

Particularly, RK3399's counter stops ticking when we switch from the
24MHz clock to the 32KHz clock in low-power suspend, so let's mark it as
such.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2: new in v2

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 76b28649f0b0..401c8be8c8ac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -174,6 +174,7 @@
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+		arm,no-tick-in-suspend;
 	};
 
 	xin24m: xin24m {
-- 
2.8.0.rc3.226.g39d4020
