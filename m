From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 24 Mar 2016 05:52:34 -0700
Subject: [PATCH v2 0/6] arm64: perf: Broadcom Vulcan PMU support
Message-ID: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleaned up event naming convention as per ARM ARM.

Added macros for complete ARMv8 recommended implementation defined events.

Common architectural and micro-architectural events which are exported to /sys
are now filtered using PMCEIDn_EL0

Added support for Broadcom Vulcan PMU. 

changes since v1 [1]:
 Incorporated the following review comments from Will.
 * cleaned up event naming convention as per ARM ARM
 * Filtered common events based on PMCEIDn_EL0
 * Removed exposing implementation defined events to /sys.

[1] http://www.spinics.net/lists/arm-kernel/msg490954.html

Ashok Kumar (6):
  arm64/perf: Changed events naming as per ARM ARM
  arm64/perf: Define complete ARMv8 recommended implementation defined
    events
  arm64/perf: Filter common events based on PMCEIDn_EL0
  arm64/perf: Add Broadcom Vulcan PMU support
  arm64: dts: Add Broadcom Vulcan PMU in dts
  Documentation: arm64: pmu: Add Broadcom Vulcan PMU binding

 Documentation/devicetree/bindings/arm/pmu.txt |   3 +-
 arch/arm64/boot/dts/broadcom/vulcan.dtsi      |   2 +-
 arch/arm64/kernel/perf_event.c                | 717 +++++++++++++++++---------
 3 files changed, 485 insertions(+), 237 deletions(-)

-- 
2.1.0
