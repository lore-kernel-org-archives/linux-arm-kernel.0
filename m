From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 25 Sep 2013 21:18:12 -0400
Subject: [PATCH v3 0/3] clk: keystone: Add common clock drivers
Message-ID: <1380158295-30629-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Here is the updated version of the series as aligned on the list.
Patchset is also available on my git tree [1]

v3:
Removed the dependency with common clock dt bindings for mux and
divider considering they are still under discussion. Only first
patch has changed from last version.

v2:
- Aligned the bindings as per the list discussion. Removed the additional
	parameters by usage of reg-names and additional compatible fields.
- Addressed all the comments from v1 on drivers.
- Split the series into clock drivers($subject series) and
	platform, dt updates. Will post that one separately.

Special thanks to Mike and Mark for the detailed review on v1.

Series is an attempt to add the clock drivers for Keystone SOCs
based on common clock framework. A PLL drivers taking care of
SOC PLLs and a gate control driver taking clock management for
the IPs. The current Keystone based SOCs don' support dynamic power
management usecases like DVFS, SOC ilde etc and hence most of the
usage is limited to enabling clocks and finding the current clock
rate etc.

Tested on Keystone2 EVM.

Cc: Mike Turquette <mturquette@linaro.org>

Santosh Shilimkar (3):
  clk: keystone: add Keystone PLL clock driver
  clk: keystone: Add gate control clock driver
  clk: keystone: Build Keystone clock drivers

 .../devicetree/bindings/clock/keystone-gate.txt    |   29 ++
 .../devicetree/bindings/clock/keystone-pll.txt     |   84 ++++++
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/keystone/Makefile                      |    1 +
 drivers/clk/keystone/gate.c                        |  264 +++++++++++++++++
 drivers/clk/keystone/pll.c                         |  305 ++++++++++++++++++++
 7 files changed, 691 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-gate.txt
 create mode 100644 Documentation/devicetree/bindings/clock/keystone-pll.txt
 create mode 100644 drivers/clk/keystone/Makefile
 create mode 100644 drivers/clk/keystone/gate.c
 create mode 100644 drivers/clk/keystone/pll.c


Regards,
Santosh

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
for_3.13/keystone/clock

-- 
1.7.9.5
