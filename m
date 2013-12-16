From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:09 -0700
Subject: [GIT PULL 07/10] ARM: tegra: Trusted Foundations firmware support
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Trusted Foundations secure-mode firmware, as found
on NVIDIA SHIELD. This allows Linux to run in non-secure mode on this
board; all previous Tegra support has assumed the kernel is running in
secure mode.

This branch is based on v3.13-rc1, and shouldn't cause any merge
conflicts.

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.14-trusted-foundations

for you to fetch changes up to f47d41acfd65919c669921674444caa471723c87:

  ARM: tegra: support Trusted Foundations by default

----------------------------------------------------------------

Alexandre Courbot (7):
      ARM: add basic support for Trusted Foundations
      of: add vendor prefix for Trusted Logic Mobility
      of: add Trusted Foundations bindings documentation
      ARM: tegra: add support for Trusted Foundations
      ARM: tegra: split setting of CPU reset handler
      ARM: tegra: set CPU reset handler using firmware
      ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tlm,trusted-foundations.txt    | 20 +++++
 Documentation/devicetree/bindings/arm/tegra.txt |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt     |  1 +
 arch/arm/Kconfig                                |  2 +
 arch/arm/Makefile                               |  1 +
 arch/arm/configs/tegra_defconfig                |  1 +
 arch/arm/firmware/Kconfig                       | 28 +++++++
 arch/arm/firmware/Makefile                      |  1 +
 arch/arm/firmware/trusted_foundations.c         | 81 ++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h      | 67 ++++++++++++++++
 arch/arm/mach-tegra/Kconfig                     |  1 +
 arch/arm/mach-tegra/reset.c                     | 40 +++++++---
 arch/arm/mach-tegra/tegra.c                     |  2 +
 13 files changed, 239 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h
