From: acourbot@nvidia.com (Alexandre Courbot)
Date: Thu, 13 Jun 2013 18:12:22 +0900
Subject: [PATCH v2 0/3] ARM: tegra: add basic support for Trusted Foundations
Message-ID: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New revision of the initial patch, fixed according to the many suggestions
received. (thanks!)

Changes since v1:
- Split patch into logical chunks as suggested by Tomasz
- Simplified smc function according to comments from Russel and David
- Use proper "Trusted Foundations" naming for firmware instead of "SecureOS"
- Very simple firmware infrastructure in mach-tegra to support the use of other
  firmwares
- Presence of secure monitor is signaled through a DT node instead of a "chosen"
  property
- Complain if support for a declared secure monitor is not compiled in

Alexandre Courbot (3):
  ARM: tegra: basic support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op

 Documentation/devicetree/bindings/arm/tegra.txt    | 11 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/mach-tegra/Kconfig                        | 14 ++++++
 arch/arm/mach-tegra/Makefile                       |  3 ++
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/firmware.c                     | 40 +++++++++++++++++
 arch/arm/mach-tegra/firmware.h                     | 19 ++++++++
 arch/arm/mach-tegra/reset.c                        | 40 ++++++++++++-----
 arch/arm/mach-tegra/trusted_foundations.c          | 51 ++++++++++++++++++++++
 10 files changed, 171 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-tegra/firmware.c
 create mode 100644 arch/arm/mach-tegra/firmware.h
 create mode 100644 arch/arm/mach-tegra/trusted_foundations.c

-- 
1.8.3
