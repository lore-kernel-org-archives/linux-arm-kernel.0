From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 Aug 2017 11:37:48 -0700
Subject: [GIT PULL 6/6] Broadcom drivers changes for 4.14
In-Reply-To: <20170817183748.1450-1-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
Message-ID: <20170817183748.1450-7-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.14/drivers

for you to fetch changes up to 7f95522be533c27a918fe388ae5d733344660ef2:

  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS) (2017-07-28 16:57:03 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64 SoC drivers changes for 4.14,
please pull the following:

- Markus adds support for the Broadcom STB DDR PHY frontend which supports
  dynamic firmware loading and offers the ability to respond with DRAM refresh
  rates. He also adds a proper documentation binding document for that peripheral

- Brian adds support for S2/S3/S5 system suspend/resume modes on ARM-based SoCs
  which is not new but had been lingering for a long time

- Justin adds S2/S3 system suspend/resume modes on MIPS-based SoCs which is a
  bit new newer and builds on top of the ARM-based support

- Florian adds Device Tree binding documents for both ARM and MIPS based systems
  describing the necessary nodes for S2/S3/S5 on these SoCs

----------------------------------------------------------------
Brian Norris (1):
      soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Florian Fainelli (2):
      dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management binding
      dt-bindings: Document MIPS Broadcom STB power management nodes

Justin Chen (1):
      soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

Markus Mayer (2):
      dt/bindings: Add bindings for Broadcom STB DRAM Sensors
      soc: brcmstb: Add driver for DPFE

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
 .../devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt  |  27 +
 MAINTAINERS                                        |   8 +
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |   9 +
 drivers/soc/bcm/brcmstb/Makefile                   |   3 +-
 drivers/soc/bcm/brcmstb/dpfe.c                     | 689 +++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 822 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 16 files changed, 2805 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,dpfe-cpu.txt
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
 create mode 100644 drivers/soc/bcm/brcmstb/dpfe.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S
