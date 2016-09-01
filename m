From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 31 Aug 2016 21:53:26 -0500
Subject: [PATCH v2 0/2] cpufreq: Introduce TI CPUFreq/OPP Driver
Message-ID: <20160901025328.376-1-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series is v2 of the series to introduce the ti-cpufreq driver
which parses SoC data and provides opp-supported-hw data to the
OPP core in order to enable the proper OPPs for the silicon in use.
v1 of this series can be found here [1].

Mostly minor fixes to the driver with the largest being converting to the
driver to a module_platform_driver. In addition to this, the binding was
updated to add TI specific compatible strings for the SoCs supported by the
driver that it matches now. More specific driver changes can be found in
the patches.

This patch depends on [2], which actually has already been merged even though
the binding was not finalized yet, so another series here [3] was sent to
update the already merged dt nodes.

Regards,
Dave

[1] https://lkml.org/lkml/2016/5/18/653
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430205.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452981.html

Dave Gerlach (2):
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 130 +++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/ti-cpufreq.c                       | 308 +++++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

-- 
2.9.0
