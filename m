From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 7 Nov 2013 19:11:39 +0900
Subject: [PATCH v10 0/7] ARM: support for Trusted Foundations secure monitor
Message-ID: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a set of small fixes to address the concerns expressed on v9 with the
non-prefixed version DT properties. I hope there won't be a need for an
eleventh (!) version. :P

Changelog from v9:
- Renamed tl vendor prefix to tlm (for Trusted Logic Mobility)
- Prefixed version properties with "tlm,"
- Split the DT bindings patches as per new recommendations

Alexandre Courbot (7):
  ARM: add basic support for Trusted Foundations
  of: add vendor prefix for Trusted Logic Mobility
  of: add Trusted Foundations bindings
  ARM: tegra: add support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op
  ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tlm,trusted-foundations.txt       | 20 ++++++
 Documentation/devicetree/bindings/arm/tegra.txt    |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/firmware/Kconfig                          | 28 ++++++++
 arch/arm/firmware/Makefile                         |  1 +
 arch/arm/firmware/trusted_foundations.c            | 81 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h         | 67 ++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/reset.c                        | 40 ++++++++---
 13 files changed, 239 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h

-- 
1.8.4.2
