From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Aug 2018 17:36:42 +0100
Subject: [GIT PULL] arm64: merge window fixes for -rc1
Message-ID: <20180817163641.GC12205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I'm travelling next week and a couple of fixes came in since our main
pull request on Tuesday. Since one of them fixes a boot failure on
Hikey-960, I figured there was no point holding them off until -rc1 is
released, so please consider pulling them beforehand.

Details in the tag.

Cheers,

Will

--->8

The following changes since commit 3c4d9137eefecf273a520d392071ffc9df0a9a7a:

  arm64: alternative: Use true and false for boolean values (2018-08-08 11:20:54 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5ad356eabc47d26a92140a0c4b20eba471c10de3:

  arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid() (2018-08-17 10:27:14 +0100)

----------------------------------------------------------------
A couple of arm64 fixes

- Fix boot on Hikey-960 by avoiding an IPI with interrupts disabled
- Fix address truncation in pfn_valid() implementation

----------------------------------------------------------------
Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Will Deacon (1):
      arm64: Avoid calling stop_machine() when patching jump labels

 arch/arm64/kernel/jump_label.c | 2 +-
 arch/arm64/mm/init.c           | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)
