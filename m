From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 28 Oct 2013 19:28:33 +0900
Subject: [PATCH v9 0/5] ARM: support for Trusted Foundations secure monitor
Message-ID: <1382956118-12495-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New attempt to get this merged. ;)

The last open discussion topic for this series is whether to move this into
drivers/ instead of having it depend on ARM. The problem is that the firmware
framework this series is built upon resides in arch/arm/. It would possibly
make sense to move it out of there as well, but doing so requires Tomasz
opinion on the matter and unfortunately I haven't been able to get feedback
from him, even after trying to contact him privately.

At the current state of things, this should be of little concern anyway.
Trusted Foundations is for the moment indeed ARM-only, and both the
Trusted Foundations driver and firmware framework can be moved out of
arch/arm/ at any time without introducing any incompatibility.

Also I have some inprovements to this driver waiting to be submitted, but
would like to get this generally-accepted part merged first instead of
adding new code that will probably need several new rounds of revisions.

Changelog from v8:
- moved includes that depended on config symbols to the top of the file
- use linux/*.h instead of asm/*.h

Alexandre Courbot (5):
  ARM: add basic support for Trusted Foundations
  ARM: tegra: add support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op
  ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tl,trusted-foundations.txt        | 20 ++++++
 Documentation/devicetree/bindings/arm/tegra.txt    |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/firmware/Kconfig                          | 28 ++++++++
 arch/arm/firmware/Makefile                         |  1 +
 arch/arm/firmware/trusted_foundations.c            | 79 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h         | 67 ++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/reset.c                        | 40 ++++++++---
 13 files changed, 237 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h

-- 
1.8.4.1
