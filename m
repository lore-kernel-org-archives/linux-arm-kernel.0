From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 31 Jan 2017 15:43:16 +0300
Subject: [PATCH v6 5/5] ARM: dts: rockchip: disable arm-global-timer for rk3188
In-Reply-To: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
References: <1485866596-32254-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1485866596-32254-6-git-send-email-al.kochet@gmail.com>
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
---
 arch/arm/boot/dts/rk3188.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 0dc52fe..44da3d42 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -546,6 +546,7 @@
 
 &global_timer {
 	interrupts = <GIC_PPI 11 0xf04>;
+	status = "disabled";
 };
 
 &local_timer {
-- 
1.7.9.5
