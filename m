From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 May 2014 15:25:12 +0100
Subject: [GIT PULL] Late regression fix for arm64
Message-ID: <20140529142512.GA6168@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Catalin's currently on holiday [1], so I'm dealing with the arm64 tree
for a change. Unfortunately, it's not as quiet as I'd like and we've got
a fix for a horrible THP regression introduced during the merge window.
The symptom tends to be CoW failures for tasks that end up using
transparent hugepages, which ultimately means random userspace breakage
for anything that uses large anonymous mappings and forks.

Please can you pull this for 3.15?

Cheers,

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259319.html

--->8

The following changes since commit c7208164e66f63e3ec1759b98087849286410741:

  Linux 3.15-rc7 (2014-05-25 16:06:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ceb218359de22e70980801d4fa04fffbfc44adb8:

  arm64: mm: fix pmd_write CoW brokenness (2014-05-29 11:31:14 +0100)

----------------------------------------------------------------
- Fix CoW regression for transparent hugepages by routing set_pmd_at to
  set_pte_at, which correctly handles PTE_WRITE and will mark the
  resulting table entry as read-only where appropriate.

----------------------------------------------------------------
Will Deacon (1):
      arm64: mm: fix pmd_write CoW brokenness

 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
