From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Feb 2016 10:49:42 +0000
Subject: [PATCH 00/13] arm-cci: PMU driver updates for 4.6
Message-ID: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some fixes and updates for arm-cci pmu driver targeting v4.6,
applies on top of v4.5-rc5.

Highlights include :
 - Support for CoreLink CCI-550 PMU
 - Reliable writes to PMU Counter registers for CCI-500/550.

All the patches have been Acked. Please let me know how this
can be merged.

Andrzej Hajda (1):
  arm-cci: fix handling cpumask_any_but return value

Mark Rutland (1):
  arm-cci: simplify sysfs attr handling

Suzuki K Poulose (11):
  arm-cci: Group writes to counter
  arm-cci: Refactor CCI PMU enable/disable methods
  arm-cci: Delay PMU counter writes to pmu::pmu_enable
  arm-cci: write_counter: Remove redundant check
  arm-cci: Get the status of a counter
  arm-cci: Add routines to save/restore all counters
  arm-cci: Add helper to enable PMU without synchornising counters
  arm-cci: Provide hook for writing to PMU counters
  arm-cci: CCI-500: Work around PMU counter writes
  arm-cci500: Rearrange PMU driver for code sharing with CCI-550 PMU
  arm-cci: CoreLink CCI-550 PMU driver

 Documentation/devicetree/bindings/arm/cci.txt |    2 +
 drivers/bus/Kconfig                           |   10 +-
 drivers/bus/arm-cci.c                         |  612 +++++++++++++++++--------
 3 files changed, 427 insertions(+), 197 deletions(-)

-- 
1.7.9.5
