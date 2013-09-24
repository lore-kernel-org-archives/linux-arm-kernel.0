From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Sep 2013 21:39:06 +0200
Subject: [GIT PULL] Nomadik AUXDATA removal
Message-ID: <CACRpkdYOLW8ZurGmQdPZY+Ysh_TkLwj4xrc758C6ojVtMnkMRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these three patches tear out the remaining AUXDATA in the
Nomadik platform and replace it with device tree.

Corresponding driver changes are coming from respective
subsystem tree and there are no build dependencies.

Please pull it in on some suitable branch in the ARM SoC
tree.

Yours,
Linus Walleij

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/for-arm-soc

for you to fetch changes up to 2c5a7424dae5e34b977716f9f0ab8a99d00cc7bc:

  ARM: nomadik: delete FSMC platform data (2013-09-24 21:25:19 +0200)

----------------------------------------------------------------
- Update device tree for VMMC regulator data
- Supply SD/MMC voltage from the VMMC regulator
- Delete auxdata for SD/MMC card and rely on DT only
- Update device tree for FSMC NAND merged for v3.12-rc1
- Delete auxdata for FSMC NAND

----------------------------------------------------------------
Linus Walleij (3):
      ARM: nomadik: register VMMC regulator
      ARM: nomadik: delete MMCI platform data
      ARM: nomadik: delete FSMC platform data

 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 12 ++++++++--
 arch/arm/mach-nomadik/cpu-8815.c           | 35 +-----------------------------
 2 files changed, 11 insertions(+), 36 deletions(-)
