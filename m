From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 11:22:39 +0000
Subject: [GIT PULL] ARM perf updates for 3.15
Message-ID: <20140228112239.GB674@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please can you pull these perf updates for 3.15?

The highlights are:

  * Support for Qualcomm Krait processors (run perf on your phone!)
  * Support for Cortex-A12 (run perf stat on your FPGA!)
  * Support for perf_sample_event_took, allowing us to automatically decrease
    the sample rate if we can't handle the PMU interrupts quickly enough
    (run perf record on your FPGA!).

As part of the Krait support, we also gain support for PPI generation by
the PMU.

Cheers,

Will

--->8


The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/perf

for you to fetch changes up to 8e781f65423c2e8e65a56972ba996b6c01a5ef3e:

  ARM: perf: add support for the Cortex-A12 PMU (2014-02-21 11:11:23 +0000)

----------------------------------------------------------------
Albin Tonnerre (1):
      ARM: perf: add support for the Cortex-A12 PMU

Mark Rutland (1):
      ARM: perf: remove unused PMU probing code

Stephen Boyd (6):
      ARM: perf: support percpu irqs for the CPU PMU
      ARM: perf: assign pdev pointer earlier for CPU PMUs
      ARM: perf: add basic support for Krait CPU PMUs
      ARM: perf: add hook for event index clearing
      ARM: perf: fully support Krait CPU PMU events
      devicetree: bindings: Document Krait performance monitor units (PMU)

Will Deacon (1):
      ARM: perf: hook up perf_sample_event_took around pmu irq handling

 Documentation/devicetree/bindings/arm/pmu.txt |  10 +-
 arch/arm/include/asm/pmu.h                    |   2 +
 arch/arm/kernel/perf_event.c                  |  27 +-
 arch/arm/kernel/perf_event_cpu.c              | 113 ++--
 arch/arm/kernel/perf_event_v7.c               | 717 ++++++++++++++++++++++++++
 5 files changed, 824 insertions(+), 45 deletions(-)
