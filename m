From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Mar 2015 05:04:46 +0800
Subject: [PATCH 0/3] ARM: dts: sun6i: Enable cpufreq support for A31/A31s
Message-ID: <1427317489-708-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds the DT parts of cpufreq support, clock references, thermal
zones and OPPs, for sun6i. This is based on sunxi/for-next (6bcf44d5edfb).
Required (sun4i-ts) driver support is already in v4.0-rc1.

Patch 1 moves the ahb1 assigned-clocks reparenting properties from the dma
controller node to the ahb1 clock node. This matches what we've done for
sun5i and sun7i. The purpose of this is to clock ahb1 from a stable clock
as soon as possible, to prevent hrtimer miscalculation/instability.

Patch 2 adds the clock reference and OPPs for the cpu cluster.

Patch 3 adds the thermal zones for CPU passive (cpufreq limiting) cooling.

I've tested this on my Sinlinx SinA31s (not yet mainlined). The highest
OPP matches the default CPU clock/voltage setting found in mainline
u-boot. However the Mele I7 fex file specifies a slightly higher voltage
for 1008 MHz. If the default setting is not stable enough for the Mele
I7, it should be overridden in the board dts file.

This series does not cover A31/A31s revision D, which seems to have lower
voltage requirements. At the moment no one has seen them.


Regards
ChenYu


Chen-Yu Tsai (3):
  ARM: dts: sun6i: Set PLL6 as parent to AHB1 clock in AHB1 clock node
  ARM: dts: sun6i: Add cpu clock reference and operating points to dtsi
  ARM: dts: sun6i: Add cpu thermal zones to dtsi

 arch/arm/boot/dts/sun6i-a31.dtsi | 59 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

-- 
2.1.4
