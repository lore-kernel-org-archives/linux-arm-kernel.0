From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 24 Dec 2016 13:59:22 +0000
Subject: [GIT PULL] efi: urgent fix for v4.10 with cc to stable
Message-ID: <1482587963-20183-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to bcd5812b8bfb24783f09b53659fae54d1b02d0be:

  efi/libstub: arm*: Pass latest memory map to the kernel (2016-12-24 13:19:28 +0000)

----------------------------------------------------------------
* One patch, addressing a major issue in a bugfix that went into stable,
  where on ARM/arm64 systems, the EFI memory map address passed to the
  kernel via the FDT may be different from the address of the buffer
  containing the annotated EFI memory map.

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/libstub: arm*: Pass latest memory map to the kernel

 drivers/firmware/efi/libstub/efistub.h |  8 ----
 drivers/firmware/efi/libstub/fdt.c     | 87 ++++++++++++++++++++++------------
 2 files changed, 56 insertions(+), 39 deletions(-)
