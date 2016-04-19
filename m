From: ashoks@broadcom.com (Ashok Kumar)
Date: Tue, 19 Apr 2016 11:54:15 -0700
Subject: [PATCH v5 0/7] arm64: perf: Broadcom Vulcan PMU support
Message-ID: <1461092062-7484-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaned up event naming convention as per ARM ARM.

Added macros for complete ARMv8 recommended implementation defined events.

changed pmu register access to make use of read/write_sys_reg.

Common architectural and micro-architectural events which are exported to /sys
are now filtered using PMCEIDn_EL0

Added support for Broadcom Vulcan PMU.

changes since v4 [4]:
 * Used read/write_sys_reg for pmu register access as per Suzuki's review 
   comment from v2.

changes since v3 [3]:
 * Changed the order of patchset to match devicetree submission guidelines.
 * Rebased on 4.6-rc3

changes since v2 [2]:
 * Changed event filtering mechanism to use is_visible function pointer
   of attribute_group instead of copying to a new events attribute 
   structure as per Mark's review comments.

changes since v1 [1]:
 Incorporated the following review comments from Will.
 * cleaned up event naming convention as per ARM ARM
 * Filtered common events based on PMCEIDn_EL0
 * Removed exposing implementation defined events to /sys.

[1] http://www.spinics.net/lists/arm-kernel/msg490954.html
[2] http://www.spinics.net/lists/arm-kernel/msg492439.html
[3] http://www.spinics.net/lists/arm-kernel/msg492941.html
[4] http://www.spinics.net/lists/arm-kernel/msg496151.html

Ashok Kumar (7):
  Documentation: arm64: pmu: Add Broadcom Vulcan PMU binding
  arm64: dts: Add Broadcom Vulcan PMU in dts
  arm64/perf: Changed events naming as per ARM ARM
  arm64/perf: Define complete ARMv8 recommended implementation defined
    events
  arm64/perf: Access pmu register using <read/write>_sys_reg
  arm64/perf: Filter common events based on PMCEIDn_EL0
  arm64/perf: Add Broadcom Vulcan PMU support

 Documentation/devicetree/bindings/arm/pmu.txt |   3 +-
 arch/arm64/boot/dts/broadcom/vulcan.dtsi      |   2 +-
 arch/arm64/kernel/perf_event.c                | 550 +++++++++++++++++---------
 include/linux/perf/arm_pmu.h                  |   2 +
 4 files changed, 373 insertions(+), 184 deletions(-)

-- 
2.1.0
