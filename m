From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Jul 2015 14:35:49 +0200
Subject: [PATCH 0/3] ARM: berlin: add cpufreq support for the BG2Q
Message-ID: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the cpufreq support to the Berlin BG2Q SoC only, as I
told this couldn't be done for BG2 and BG2CD.

First, the cpuclk clock is added to the Berlin clock driver. This clock
has a divider fixed to 1, so we use a fixed factor clock here.

Then register a platform device for cpufreq-dt, when using a BG2Q.

I also added the OPP table definition in the BG2Q device tree. Some
bootloaders may update this table when booting. Mine doesn't.

Tested on a BG2Q DMP.

Thanks,

Antoine

Antoine Tenart (3):
  clk: berlin: add cpuclk
  ARM: berlin: register cpufreq-dt for the BG2Q
  ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q

 arch/arm/boot/dts/berlin2q.dtsi      | 11 +++++++++++
 arch/arm/mach-berlin/berlin.c        | 13 +++++++++++++
 drivers/clk/berlin/bg2q.c            | 14 +++++++-------
 include/dt-bindings/clock/berlin2q.h |  3 ++-
 4 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.5.0
