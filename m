From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Apr 2017 10:32:00 +0100
Subject: [GIT PULL] EFI fixup for v4.12 queue
Message-ID: <20170417093201.10181-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please merge this onto the v4.12 EFI queue: it fixes an issue reported with
-next where arm64 machines fail to boot due to a premature dereference of the
'current' pointer.

The following changes since commit efc491b0f06f65ea588f6591f0bc31db779e0594:

  ef/libstub: arm/arm64: Randomize the base of the UEFI rt services region (2017-04-02 16:36:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next

for you to fetch changes up to d3e759649e1b057da72a8981aaafcd2f34f10681:

  efi/libstub/arm: Don't use TASK_SIZE when randomising the RT space (2017-04-17 08:16:25 +0100)

----------------------------------------------------------------
A single fix for a regression caused by changes that are queued for v4.12:
- don't use TASK_SIZE in the stub on arm64, as it depends on thread flags

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/libstub/arm: Don't use TASK_SIZE when randomising the RT space

 drivers/firmware/efi/libstub/arm-stub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
