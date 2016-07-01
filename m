From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  1 Jul 2016 15:36:08 +0800
Subject: [PATCH 0/2] arm64: dts: rockchip: Support PMU for rk3399 SoCs
Message-ID: <1467358570-24417-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko, Marc & ARM guys

When Jay first submitted the rk3399.dtsi upstream
<https://patchwork.kernel.org/patch/8885821/> he had the PMU node in there,
but then took it out because the upstream binding wasn't done yet.
It looks as if the upstream stuff has landed, since in linux/master I see:
287e9357abcc DT/arm,gic-v3: Documment PPI partition support
e3825ba1af3a irqchip/gic-v3: Add support for partitioned PPIs
9e2c986cb460 irqchip: Add per-cpu interrupt partitioning library
222df54fd8b7 genirq: Allow the affinity of a percpu interrupt to be set/retrieved
651e8b54abde irqdomain: Allow domain matching on irq_fwspec

This series patches add to support the rk3399 SoCs PMU.
As my do some tests with ChromeOs for my rk3399 board.

TEST=$perf list |grep Hardware
cpu-cycles OR cycles                               [Hardware event]
instructions                                       [Hardware event]
cache-references                                   [Hardware event]
branch-instructions OR branches                    [Hardware event]
branch-misses                                      [Hardware event]
..
Also,
localhost / # perf stat sleep 1
watch the Hardware event.
e.g.:
2375647      instructions              #    0.79  insns per cycle
18482      branch-misses             #    0.00% of all branches
--

And perf top/stat to watch the hardware event. That work for me on now.

-Caesar



Caesar Wang (2):
  arm64: dts: rockchip: change all interrupts cells for 4 on rk3399 SoCs
  arm64: dts: rockchip: support the pmu node for rk3399

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 124 +++++++++++++++++++------------
 1 file changed, 75 insertions(+), 49 deletions(-)

-- 
1.9.1
