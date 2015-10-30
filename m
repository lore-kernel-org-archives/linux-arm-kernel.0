From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Oct 2015 11:28:43 +0000
Subject: [GIT PULL] arm64: late fixes for 4.3
Message-ID: <20151030112843.GC20030@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Apologies for this being so late, but we've uncovered a few nasty issues
on arm64 which didn't settle down until yesterday and the fixes all look
suitable for 4.3. Of the four patches, three of them are Cc'd to stable,
with the remaining patch fixing an issue that only took effect during
the merge window. Brief summaries are available in the tag.

Please pull.

Thanks,

Will

--->8

The following changes since commit 32b88194f71d6ae7768a29f87fbba454728273ee:

  Linux 4.3-rc7 (2015-10-25 10:39:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 73effccb9196ccc0241c3fb51dfd8de1d14ae8ed:

  arm64/efi: do not assume DRAM base is aligned to 2 MB (2015-10-29 16:10:58 +0000)

----------------------------------------------------------------
arm64 fixes for 4.3

- Fix corruption in SWP emulation when STXR fails due to contention
- Fix MMU re-initialisation when resuming from a low-power state
- Fix stack unwinding code to match what ftrace expects
- Fix relocation code in the EFI stub when DRAM base is not 2MB aligned

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/efi: do not assume DRAM base is aligned to 2 MB

Lorenzo Pieralisi (1):
      arm64: kernel: fix tcr_el1.t0sz restore on systems with extended idmap

Will Deacon (2):
      arm64: compat: fix stxr failure case in SWP emulation
      Revert "ARM64: unwind: Fix PC calculation"

 arch/arm64/kernel/armv8_deprecated.c | 16 +++++++++-------
 arch/arm64/kernel/efi-stub.c         | 14 ++++++++++++--
 arch/arm64/kernel/stacktrace.c       |  6 +-----
 arch/arm64/kernel/suspend.c          | 22 +++++++++++++---------
 4 files changed, 35 insertions(+), 23 deletions(-)
