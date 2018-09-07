From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 Sep 2018 16:45:16 +0100
Subject: [GIT PULL] arm64: fix for -rc3
Message-ID: <20180907154516.GG12788@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Just one small fix here, preventing a VM_WARN_ON when a !present PMD/PUD
is "freed" as part of a huge ioremap() operation. The correct behaviour
is to skip the free silently in this case, which is a little weird (the
function is a bit of a misnomer), but it follows the x86 implementation.

I also renewed the expiry dates on my gpg subkeys this week, so you might
need to re-fetch them if you can find a working keyserver.

Cheers,

Will

--->8

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to fac880c7d074fdfca874114b5c47b36aa034e4ee:

  arm64: fix erroneous warnings in page freeing functions (2018-09-06 18:01:13 +0100)

----------------------------------------------------------------
arm64 fix

- Remove accidental VM_WARN_ON

----------------------------------------------------------------
Mark Rutland (1):
      arm64: fix erroneous warnings in page freeing functions

 arch/arm64/mm/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
