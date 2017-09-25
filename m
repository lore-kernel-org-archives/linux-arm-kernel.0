From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 25 Sep 2017 12:01:12 -0700
Subject: [GIT PULL 2/2] Broadcom drivers changes for 4.15 (part 1)
In-Reply-To: <20170925190112.3915-1-f.fainelli@gmail.com>
References: <20170925190112.3915-1-f.fainelli@gmail.com>
Message-ID: <20170925190112.3915-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/drivers

for you to fetch changes up to 0e9b11413262ef3d64273e15f7631d9836c53c1a:

  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS) (2017-09-25 11:47:14 -0700)

----------------------------------------------------------------
This pull requests contains Broadcom SoCs drivers updates for 4.15, please pull
the following:

- Markus adds support for the Broadcom STB DDR PHY frontend which supports
  dynamic firmware loading and offers the ability to respond with DRAM refresh
  rates. He also adds a proper documentation binding document for that
  peripheral

- Brian adds support for S2/S3/S5 system suspend/resume modes on ARM-based SoCs
  which is not new but had been lingering for a long time.

- Justin adds S2/S3 system suspend/resume modes on MIPS-based SoCs which is a
  bit new newer and builds on top of the ARM-based support.

- Florian adds Device Tree binding documents for both ARM and MIPS based systems
  describing the necessary nodes for S2/S3/S5 on these SoCs.

(This pull request somehow missed the 4.14 merge window and is now being sent again
for 4.15 along with build fixes from Arnd).

----------------------------------------------------------------
Brian Norris (1):
      soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Florian Fainelli (2):
      dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management binding
      dt-bindings: Document MIPS Broadcom STB power management nodes

Justin Chen (1):
      soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

Markus Mayer (2):
      dt-bindings: Add bindings for Broadcom STB DRAM Sensors
      memory: brcmstb: Add driver for DPFE

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../bindings/memory-controllers/brcm,dpfe-cpu.txt  |  27 +
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
 MAINTAINERS                                        |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/brcmstb_dpfe.c                      | 701 ++++++++++++++++++
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |  10 +
 drivers/soc/bcm/brcmstb/Makefile                   |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 822 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 17 files changed, 2818 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
 create mode 100644 drivers/memory/brcmstb_dpfe.c
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S
