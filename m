From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Mar 2015 17:22:47 +0000
Subject: [GIT PULL] ARM perf updates for 4.1
Message-ID: <20150327172246.GN1562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull the following ARM perf updates for 4.1? The
highlight is the addition of Qualcomm Scorpion support from Stephen, but
there's also a small fix and a device-tree parsing update to allow for
explicit specification of PMU interrupt affinity.

Thanks,

Will

--->8

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 9fd85eb502a78bd812db58bd1f668b2a06ee30a5:

  ARM: pmu: add support for interrupt-affinity property (2015-03-24 15:07:57 +0000)

----------------------------------------------------------------
Stephen Boyd (3):
      ARM: perf: Preparatory work for Scorpion PMU support
      ARM: perf: Only reset PMxEVCNTCR registers on reset
      ARM: perf: Add support for Scorpion PMUs

Suzuki K. Poulose (1):
      ARM: perf: reject groups spanning multiple hardware PMUs

Will Deacon (1):
      ARM: pmu: add support for interrupt-affinity property

 Documentation/devicetree/bindings/arm/pmu.txt |   2 +
 arch/arm/include/asm/pmu.h                    |   1 +
 arch/arm/kernel/perf_event.c                  |  21 +-
 arch/arm/kernel/perf_event_cpu.c              |  71 +++-
 arch/arm/kernel/perf_event_v7.c               | 525 +++++++++++++++++++++++---
 5 files changed, 548 insertions(+), 72 deletions(-)
