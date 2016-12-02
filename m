From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 16:42:44 +0000
Subject: [stable:PATCH 0/3] PAN fixes backport for v4.4.35
Message-ID: <20161202164247.19496-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi linux-stable,

This is the backport of the recent PAN fixes series for v4.4.35.
Original series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461806.html

Patch 1 changes the prototype of all the feature/errata enable calls, so
is fiddly to backport, hence doing it later as a separate series.

Patch 3 has had the UAO desription removed from its commit message as
v4.4 doesn't support this feature.

Thanks,

James Morse (3):
  arm64: cpufeature: Schedule enable() calls instead of calling them via
    IPI [v4.4]
  arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call [v4.4]
  arm64: suspend: Reconfigure PSTATE after resume from idle [v4.4]

 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/processor.h  |  2 +-
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/kernel/suspend.c         |  9 +++++++++
 arch/arm64/mm/fault.c               | 12 +++++++++++-
 5 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.10.1
