From: james.morse@arm.com (James Morse)
Date: Tue,  6 Dec 2016 19:04:51 +0000
Subject: [stable:PATCH 0/3] PAN fixes backport for v4.8.12
Message-ID: <20161206190454.19083-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, linux-stable,

This is the backport of the recent PAN fixes series for v4.8.
Original series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461806.html

Next time I will remember to work backwards through stable versions.
Sorry for the confusion!

Thanks,

James Morse (3):
  arm64: cpufeature: Schedule enable() calls instead of calling them via
    IPI [v4.8]
  arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call [v4.8]
  arm64: suspend: Reconfigure PSTATE after resume from idle [v4.8]

 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/exec.h       |  3 +++
 arch/arm64/include/asm/processor.h  |  6 +++---
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/kernel/process.c         |  3 ++-
 arch/arm64/kernel/suspend.c         | 11 +++++++++++
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               | 15 +++++++++++++--
 8 files changed, 44 insertions(+), 9 deletions(-)

-- 
2.10.1
