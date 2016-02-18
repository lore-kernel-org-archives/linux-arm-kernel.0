From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 18 Feb 2016 17:50:09 +0100
Subject: [PATCH v4 0/5] Cavium ThunderX PMU support
Message-ID: <cover.1455810755.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this should address all comments. With the simplified event mask
arm isn't touched anymore and also the cpuid check vanished.

Changes to v3:
- renamed A57 events to IMPDEF
- changed comment about 64 bit cycle counter overflow
- unconditionally increase event mask

Changes to v2:
- fixed arm compile errors

Changes to v1:
- renamed thunderx dt pmu binding to thunder

Jan

--------------------------------------------------------

Jan Glauber (5):
  arm64/perf: Rename Cortex A57 events
  arm64/perf: Add Cavium ThunderX PMU support
  arm64: dts: Add Cavium ThunderX specific PMU
  arm64/perf: Enable PMCR long cycle counter bit
  arm64/perf: Extend event mask for ARMv8.1

 Documentation/devicetree/bindings/arm/pmu.txt |   1 +
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  |   5 ++
 arch/arm64/kernel/perf_event.c                | 120 +++++++++++++++++++++-----
 3 files changed, 105 insertions(+), 21 deletions(-)

-- 
1.9.1
