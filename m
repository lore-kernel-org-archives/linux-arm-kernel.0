From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 01 Dec 2017 11:53:05 -0800
Subject: [GIT PULL] revert ARM SCPI changes for v4.15-rc1
Message-ID: <7hlgimns2m.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

These ARM SCPI changes caused SCPI regressions resulting in CPUfreq
failures on most Amlogic SoCs (found by kernelci.org.)

Unfortunately, this was not caught in linux-next due to other
bugs/panics on these platforms masking this problem so we've only found
it since we've fixed the other issues.

Since we're already in the -rc cycle, I'd prefer to revert to a known
working state (that of v4.14) rather than finding/reverting a subset,
which would just lead to another untested state.

These changes can then have some time to be better reviewed and tested
and resubmitted for v4.16.

I've tested this revert on the affect Amlogic SoCs and verified that
we're back to the previous (working) condition.

Also, I'm sending the pull directly to arm-soc instead of Sudeeep
because I understand that Sudeep is currently out-of-office and unlikely
to be able to address this himself during the -rc cycle.

Please pull,

Thanks,

Kevin


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/scpi-revert

for you to fetch changes up to 5f56b7f4854aaab34eb570c24a1866b2050fc3f5:

  Revert "Merge tag 'scpi-updates-4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into next/drivers" (2017-12-01 10:56:35 -0800)

----------------------------------------------------------------
Revert ARM SCPI changes since v4.14.

Untested changes caused regressions in SCPI and CPUfreq/DVFS failures
on most Amlogic SoCs.  Changes reverted for v4.15 so they can be
better reviewed and tested.

----------------------------------------------------------------
Kevin Hilman (1):
      Revert "Merge tag 'scpi-updates-4.15' of git://git.kernel.org/.../sudeep.holla/linux into next/drivers"

 drivers/firmware/arm_scpi.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------
 1 file changed, 129 insertions(+), 87 deletions(-)
