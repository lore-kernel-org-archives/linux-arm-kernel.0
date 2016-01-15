From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:52 +0800
Subject: [PATCH v3 5/9] ARM: dts: rockchip: enable the high speed on sdio for
 kylin board
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-6-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to the higher speed for wifi module working.

Bootup kernel log:
...
mmc_host mmc0: Bus speed (slot 0) = 37125000Hz (slot req 37500000Hz,
actual 37125000HZ div = 0)

or run 'cat /sys/kernel/debug/clk/clk_summary |grep phase -C 1' to check
Otherwise, the mmc0 will run 400khz defalult value to work.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3: None

 arch/arm/boot/dts/rk3036-kylin.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 2a45be7..4fbd0a3 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -303,6 +303,11 @@
 
 	broken-cd;
 	bus-width = <4>;
+	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	cap-sdio-irq;
 	default-sample-phase = <90>;
 	keep-power-in-suspend;
-- 
1.9.1
