From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Nov 2014 16:19:30 -0800
Subject: [GIT PULL] Broadcom STB GISB bus driver for 3.19 (v2)
Message-ID: <1417220370-469-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/brcm/linux.git tags/arm-soc/for-3.19/brcmstb-drivers

for you to fetch changes up to d1d6786846e1c40f780edb83569597a8a7769e95:

  bus: brcmstb_gisb: Add register offset tables for older chips (2014-11-28 15:44:44 -0800)

----------------------------------------------------------------
This pull request contains the following changes to the Broadcom GISB bus
arbiter from Kevin Cernekee:

- Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only) and support
  65nm and 40nm MIPS-based chips such as: BCM7038, BCM7400 and BCM7435

----------------------------------------------------------------
Changes in v2:
- drop bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties
  since it depends on of_device_is_big_endian which is not merged yet

Kevin Cernekee (4):
      bus: brcmstb_gisb: Make the driver buildable on MIPS
      bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
      bus: brcmstb_gisb: Look up register offsets in a table
      bus: brcmstb_gisb: Add register offset tables for older chips

 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   6 +-
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/brcmstb_gisb.c                         | 118 +++++++++++++++++----
 3 files changed, 105 insertions(+), 21 deletions(-)
