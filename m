From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Nov 2014 13:27:40 +0000
Subject: [PATCH 0/3] arm64: sanity check updates
Message-ID: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fix some issues with the sanity checks code: 

* New revisions of Cortex-A53 differ from Cortex-A57 w.r.t.
  ID_MMFR0.AuxReg, but as the format and use of the auxiliary registers
  is IMPLEMENTATION DEFINED, we can safely ignore this in the kernel.
  This difference may be of importance to hypervisors, however.

* We don't sanity check ID_AA64DFR{0,1}_EL1 but rely on consistent debug
  feature support across CPUs (at least in terms of the number of
  watchpoints and breakpoints).

* A missing newline in a format string leads to odd output in the case
  of a sanity check failure.

The series has been tested on Juno and models, and no issues have been
seen.

Thanks,
Mark.

Mark Rutland (3):
  arm64: sanity checks: ignore ID_MMFR0.AuxReg
  arm64: sanity checks: add missing newline to print
  arm64: sanity checks: add ID_AA64DFR{0,1}_EL1

 arch/arm64/include/asm/cpu.h |  2 ++
 arch/arm64/kernel/cpuinfo.c  | 20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
1.9.1
