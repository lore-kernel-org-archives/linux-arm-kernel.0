From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 22 Mar 2017 18:48:34 +0300
Subject: [PATCH v7 7/7] ARM: dts: rockchip: disable arm-global-timer for rk3188
In-Reply-To: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
References: <1490197714-25415-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1490197714-25415-8-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocksource and the sched_clock provided by the arm_global_timer
are quite unstable because their rates depend on the cpu frequency.

On the other side, the arm_global_timer has a higher rating than the
rockchip_timer, it will be selected by default by the time framework
while we want to use the stable rockchip clocksource.

Let's disable the arm_global_timer in order to have the rockchip
clocksource selected by default.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index a20d501..c316468 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -548,6 +548,7 @@
 
 &global_timer {
 	interrupts = <GIC_PPI 11 0xf04>;
+	status = "disabled";
 };
 
 &local_timer {
-- 
1.7.9.5
