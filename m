From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 4 Oct 2013 09:37:10 -0700
Subject: [PATCH v7 0/5] ARM: support for Trusted Foundations secure monito
Message-ID: <1380904635-18113-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully final version of this patchset. If I'm not mistaken the last thing
that prevents Stephen from merging it is Russel's Ack. Russel, could you check
it?

Trusted Foundations is an ARM secure monitor that is used by many Tegra-based
retail devices (like SHIELD). Adding support to it allows these devices to boot
on a purely upstream kernel.

Public documentation about Trusted Foundations is scarce, but over the various
versions of this patch it has been established that it does not follow the ARM
SMC convention and also has no connection whatsoever with PSCI. As such, it
requires an implementation of its own and the firmware interface introduced by
Tomasz provides an adequate framework for it.

Changes since v6:
- Improved and simplified header conditionals when TF support is compiled in
  or not as advised by Stephen.

Alexandre Courbot (5):
  ARM: add basic support for Trusted Foundations
  ARM: tegra: add support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op
  ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tl,trusted-foundations.txt        | 17 +++++
 Documentation/devicetree/bindings/arm/tegra.txt    |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/firmware/Kconfig                          | 28 ++++++++
 arch/arm/firmware/Makefile                         |  1 +
 arch/arm/firmware/trusted_foundations.c            | 77 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h         | 64 ++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/reset.c                        | 40 +++++++----
 13 files changed, 229 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h

-- 
1.8.4
