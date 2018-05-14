From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 May 2018 17:26:07 +0100
Subject: [GIT PULL] firmware: scmi: updates for v4.18
Message-ID: <20180514162607.GC8409@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Please pull !

Regards,
Sudeep

--

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/scmi-updates-4.18

for you to fetch changes up to 632de8f542bcd44c756637da0e7d824e7129e496:

  firmware: arm_scmi: simplify exit path by returning on error (2018-05-10 10:52:00 +0100)

----------------------------------------------------------------
SCMI cleanups for v4.18

This contains all of the trivial review comments that were not
addressed as the series was already queued up for v4.17 and were not
critical to go as fixes.

They generally just improve code readability, fix kernel-docs, remove
unused/unnecessary code, follow standard function naming and simplifies
certain exit paths.

----------------------------------------------------------------
Sudeep Holla (8):
      firmware: arm_scmi: improve code readability using bitfield accessor macros
      firmware: arm_scmi: fix kernel-docs documentation
      firmware: arm_scmi: rename get_transition_latency and add_opps_to_device
      firmware: arm_scmi: rename scmi_xfer_{init,get,put}
      firmware: arm_scmi: drop unused `con_priv` structure member
      firmware: arm_scmi: remove unnecessary bitmap_zero
      firmware: arm_scmi: improve exit paths and code readability
      firmware: arm_scmi: simplify exit path by returning on error

 drivers/cpufreq/scmi-cpufreq.c      |   4 +-
 drivers/firmware/arm_scmi/base.c    |  43 +++++++-------
 drivers/firmware/arm_scmi/bus.c     |  22 ++++----
 drivers/firmware/arm_scmi/clock.c   |  24 ++++----
 drivers/firmware/arm_scmi/common.h  |  22 ++++----
 drivers/firmware/arm_scmi/driver.c  | 109 ++++++++++++++++++------------------
 drivers/firmware/arm_scmi/perf.c    |  38 ++++++-------
 drivers/firmware/arm_scmi/power.c   |  16 +++---
 drivers/firmware/arm_scmi/sensors.c |  20 +++----
 include/linux/scmi_protocol.h       |  18 ++++--
 10 files changed, 166 insertions(+), 150 deletions(-)
