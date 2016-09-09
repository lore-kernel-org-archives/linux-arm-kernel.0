From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  9 Sep 2016 14:08:25 +0100
Subject: [PATCH 0/5] arm_pmu: expose 'cpus' file in sysfs
Message-ID: <1473426510-12697-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

These are the arm_pmu patches previous posted as part of my arm_pmu/perf tools
series [1], fixed up as per your comments.

I've given this a spin on Juno, and everything seems to work as expected.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/455206.html

Mark Rutland (5):
  drivers/perf: arm_pmu: add common attr group fields
  arm64: perf: move to common attr_group fields
  arm: perf: move to common attr_group fields
  drivers/perf: arm_pmu: only use common attr_groups
  drivers/perf: arm_pmu: expose a cpumask in sysfs

 arch/arm/kernel/perf_event_v7.c | 47 ++++++++++++++++++++++++-----------------
 arch/arm64/kernel/perf_event.c  | 36 ++++++++++++++++++++-----------
 drivers/perf/arm_pmu.c          | 22 +++++++++++++++++++
 include/linux/perf/arm_pmu.h    | 11 +++++++++-
 4 files changed, 84 insertions(+), 32 deletions(-)

-- 
1.9.1
