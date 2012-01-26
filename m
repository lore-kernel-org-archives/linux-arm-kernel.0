From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jan 2012 19:07:05 +0200
Subject: [PATCH v1 0/8] Support for secondary cores on Tegra30
Message-ID: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement bringing up secondary cores on Tegra30. This involves unpowergating
the appropriate domains enabling the CPU clocks and releasing the reset lines.

Peter De Schrijver (8):
  ARM: tegra: introduce support for reading chipid
  ARM: tegra: functions to access the flowcontroller
  ARM: tegra: rework Tegra secondary CPU core bringup
  ARM: tegra: prepare powergate.c for multiple variants
  ARM: tegra: export tegra_powergate_is_powered()
  ARM: tegra: add support for Tegra30 powerdomains
  ARM: tegra: support for Tegra30 CPU powerdomains
  ARM: tegra: support for secondary cores on Tegra30

 arch/arm/mach-tegra/Makefile                 |    2 +
 arch/arm/mach-tegra/chipid.h                 |   38 +++++
 arch/arm/mach-tegra/common.c                 |    3 +
 arch/arm/mach-tegra/flowctrl.c               |   62 ++++++++
 arch/arm/mach-tegra/flowctrl.h               |    5 +
 arch/arm/mach-tegra/headsmp.S                |  192 ++++++++++++++++++++++++-
 arch/arm/mach-tegra/include/mach/iomap.h     |    3 +
 arch/arm/mach-tegra/include/mach/powergate.h |   15 ++-
 arch/arm/mach-tegra/platsmp.c                |  139 +++++++++++++------
 arch/arm/mach-tegra/powergate.c              |   53 +++++++-
 arch/arm/mach-tegra/reset.c                  |   82 +++++++++++
 arch/arm/mach-tegra/reset.h                  |   50 +++++++
 12 files changed, 588 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/mach-tegra/chipid.h
 create mode 100644 arch/arm/mach-tegra/flowctrl.c
 create mode 100644 arch/arm/mach-tegra/reset.c
 create mode 100644 arch/arm/mach-tegra/reset.h

-- 
1.7.7.rc0.72.g4b5ea.dirty
