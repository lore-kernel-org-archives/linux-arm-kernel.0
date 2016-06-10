From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Jun 2016 14:38:50 +0100
Subject: [GIT PULL] arm64: fix for -rc3
Message-ID: <20160610133850.GA14364@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull this arm64 fix for -rc3. It's a fix for an issue that Alex
saw whilst swapping with hardware access/dirty bit support enabled in
the kernel.

Cheers,

Will

--->8

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0106d456c4cb1770253fefc0ab23c9ca760b43f7:

  arm64: mm: always take dirty state from new pte in ptep_set_access_flags (2016-06-08 10:23:44 +0100)

----------------------------------------------------------------
arm64 fix:

- Fix an issue where we fail to fault in old pages on a write when
  CONFIG_ARM64_HW_AFDBM is enabled

----------------------------------------------------------------
Will Deacon (1):
      arm64: mm: always take dirty state from new pte in ptep_set_access_flags

 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
