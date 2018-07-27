From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jul 2018 12:51:34 +0100
Subject: [GIT PULL] arm64: fixes for -rc7
Message-ID: <20180727115133.GD25592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Inevitably, after saying that I hoped we would be done on the fixes front,
a couple of issues have cropped up over the last week. Next time I'll stay
schtum.

As usual, details are in the tag, but we've fixed an over-eager BUILD_BUG_ON()
which Arnd ran into with arndconfig, as well as ensuring that KPTI really
is disabled on Thunder-X1, where the cure is worse than the disease (this
regressed when we reworked the heterogeneous CPU feature checking).

Please pull.

Thanks,

Will

--->8

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7b0eb6b41a08fa1fa0d04b1c53becd62b5fbfaee:

  arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups (2018-07-25 13:32:30 +0100)

----------------------------------------------------------------
More arm64 fixes:

- Fix disabling of kpti on Thunder-X machines

- Fix premature BUILD_BUG_ON() found with randconfig

----------------------------------------------------------------
Dirk Mueller (1):
      arm64: Check for errata before evaluating cpu features

Johannes Weiner (1):
      arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

 arch/arm64/kernel/cpufeature.c | 4 ++--
 arch/arm64/mm/init.c           | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
