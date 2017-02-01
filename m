From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  1 Feb 2017 17:45:01 +0000
Subject: [GIT PULL] EFI urgent fix for v4.10
Message-ID: <1485971102-23330-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 090abfc9dc7faf3f84799f956158c8c3af149a81:

  x86/efi: Always map first physical page into EFI pagetables (2017-01-27 20:20:01 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 3436384c23eec3afff9bde221c7582f9b504ce9e:

  efi: fdt: avoid FDT manipulation after ExitBootServices() (2017-02-01 16:33:37 +0000)

----------------------------------------------------------------
* Fix for unexpected fallout of a previous urgent fix that addressed handling
  of the memory map in the EFI stub FDT code, which turns out to break systems
  that disable the MMU in ExitBootServices() (which is a highly questionable
  practice by itself)

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: fdt: avoid FDT manipulation after ExitBootServices()

 drivers/firmware/efi/libstub/fdt.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)
