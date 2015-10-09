From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 9 Oct 2015 15:17:44 +0100
Subject: [GIT PULL][1/2] ARM System Control and Power Interface(SCPI) support
Message-ID: <20151009141744.GC28928@e103737-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please consider pulling the following commits for v4.4.

Regards,
Sudeep

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/arm-scpi-for-v4.4

for you to fetch changes up to 68acc77a2d5197141ba376fd8872eccb43bfcd7d:

  hwmon: Support thermal zones registration for SCP temperature sensors (2015-10-09 11:05:53 +0100)

----------------------------------------------------------------
ARM System Control and Power Interface(SCPI) support

It adds support for the following features provided by SCP firmware
using different subsystems in Linux:
  1. SCPI mailbox protocol driver which using mailbox framework
  2. Clocks provided by SCP using clock framework
  3. CPU DVFS(cpufreq) using existing arm-big-little driver
  4. SCPI based sensors including temperature sensors

----------------------------------------------------------------
Punit Agrawal (4):
      Documentation: add DT bindings for ARM SCPI sensors
      firmware: arm_scpi: Extend to support sensors
      hwmon: Support sensors exported via ARM SCP interface
      hwmon: Support thermal zones registration for SCP temperature sensors

Sudeep Holla (5):
      Documentation: add DT binding for ARM System Control and Power Interface(SCPI) protocol
      firmware: add support for ARM System Control and Power Interface(SCPI) protocol
      clk: add support for clocks provided by SCP(System Control Processor)
      clk: scpi: add support for cpufreq virtual device
      cpufreq: arm_big_little: add SCPI interface driver

 Documentation/devicetree/bindings/arm/arm,scpi.txt | 188 +++++
 Documentation/hwmon/scpi-hwmon                     |  33 +
 MAINTAINERS                                        |  10 +
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scpi.c                             | 325 +++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scpi-cpufreq.c                     | 124 ++++
 drivers/firmware/Kconfig                           |  19 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scpi.c                        | 771 +++++++++++++++++++++
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scpi-hwmon.c                         | 288 ++++++++
 include/linux/scpi_protocol.h                      |  78 +++
 16 files changed, 1868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scpi.txt
 create mode 100644 Documentation/hwmon/scpi-hwmon
 create mode 100644 drivers/clk/clk-scpi.c
 create mode 100644 drivers/cpufreq/scpi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scpi.c
 create mode 100644 drivers/hwmon/scpi-hwmon.c
 create mode 100644 include/linux/scpi_protocol.h
