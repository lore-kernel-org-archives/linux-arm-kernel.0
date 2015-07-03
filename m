From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jul 2015 08:11:52 +0200
Subject: [PATCH RFC 0/5] cpufreq support for Marvell Armada 38x
Message-ID: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series of patches adds cpufreq support for the Marvell Armada 38x
processor. It is done in the same way it was done for Armada XP. It
was based on the work of Nadav Haklai and Neta Zur.

The first patch extends the clk-cpu clock family with the support of
the Armada 38x SoCs

The second and the third patches prepare the pmsu part to add Armada
38x support.

The third patch really add the cpufreq support, the main differences
with Armada XP is that Armada 38x SoCs uses cortex A9 and that the
frequency of the CPUs are not independent.

Then the last patch update the deice tree in order to activate this
feature.

This is still an RFC because there is still some stability issue to
fix with the current code.The solution has been found but still need
time to write it properly. As most of the code is already there your
feedback is very welcome.

Thanks,

Gregory

Gregory CLEMENT (5):
  clk: mvebu: Add Armada 38x support for clk-cpu
  ARM: mvebu: Use shorter register definition in pmsu.c
  ARM: mvebu: Made the dynamic frequency scaling support more generic
  ARM: mvebu: Armada 38x: Add dynamic frequency scaling support in pmsu
  ARM: mvebu: Update Armada 38x DT for dynamic frequency scaling

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  27 ++-
 arch/arm/boot/dts/armada-380.dtsi                  |   3 +
 arch/arm/boot/dts/armada-385.dtsi                  |   6 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   9 +
 arch/arm/mach-mvebu/pmsu.c                         | 207 ++++++++++++-------
 drivers/clk/mvebu/clk-cpu.c                        | 220 ++++++++++++++++-----
 6 files changed, 353 insertions(+), 119 deletions(-)

-- 
2.1.0
