From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 22 Mar 2017 17:00:51 +0000
Subject: [PATCH V2 0/5] soc/tegra: Enable flowctrl support for Tegra132/210
Message-ID: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flowctrl modules is supported by both Tegra132 and Tegra210 devices.
These devices already have the flowctrl node defined in their respective
*.dtsi device-tree files. The flowctrl driver is currently located in
the arch/arm/mach-tegra directory and so can only be used for 32-bit
Tegra devices. Move this driver into drivers/soc/tegra so that it can
be used for all Tegra devices that support flowctrl.

I have also added a couple clean-up patches.

Changes since V1:
- Updated warning message per Thierry's feedback
- Added stub functions for public flowctrl APIs
- Added patch to register flowctrl driver as a platform driver
- Updated formatting of DT compatible strings per Thierry's feedback.

Jon Hunter (5):
  ARM: tegra: Remove unnecessary inclusion of flowctrl header
  soc/tegra: Move Tegra flowctrl driver
  soc/tegra: flowctrl: Add basic platform driver
  dt-bindings: tegra: Update compatible strings for Tegra flowctrl
  soc/tegra: Add initial flowctrl support for Tegra132/210

 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt |   7 +-
 arch/arm/mach-tegra/Makefile                       |   1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c              |   3 +-
 arch/arm/mach-tegra/flowctrl.c                     | 179 ----------------
 arch/arm/mach-tegra/flowctrl.h                     |  66 ------
 arch/arm/mach-tegra/platsmp.c                      |   2 +-
 arch/arm/mach-tegra/pm.c                           |   2 +-
 arch/arm/mach-tegra/reset-handler.S                |   2 +-
 arch/arm/mach-tegra/sleep-tegra20.S                |   3 +-
 arch/arm/mach-tegra/sleep-tegra30.S                |   2 +-
 arch/arm/mach-tegra/sleep.S                        |   2 -
 arch/arm/mach-tegra/tegra.c                        |   2 -
 drivers/soc/tegra/Kconfig                          |   9 +
 drivers/soc/tegra/Makefile                         |   1 +
 drivers/soc/tegra/flowctrl.c                       | 224 +++++++++++++++++++++
 include/soc/tegra/flowctrl.h                       |  82 ++++++++
 16 files changed, 330 insertions(+), 257 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/flowctrl.c
 delete mode 100644 arch/arm/mach-tegra/flowctrl.h
 create mode 100644 drivers/soc/tegra/flowctrl.c
 create mode 100644 include/soc/tegra/flowctrl.h

-- 
2.7.4
