From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 26 Jun 2017 15:32:40 -0700
Subject: [PATCH v2 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
Message-ID: <20170626223248.14199-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for S2/S3/S5 suspend/resume states on
ARM and MIPS based Broadcom STB SoCs.

This was submitted a long time ago by Brian, and I am now picking this
up and trying to get this included with support for our latest chips.

Provided that I can collect the necessary Acks from Rob (DT) and other
people (Rafael?) I would probably take this via the Broadcom ARM SoC
pull requests.

Thank you!

Changes in v2:

- clarify the first patch's subject (Rob)
- removed patch #2 which was creating a bisectability problem (kbuild)
- added proper AFLAGS to get s2-arm.S to build properly (kbuild)
- improved MIPS power management binding document (Rob)

Brian Norris (1):
  soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)

Florian Fainelli (2):
  dt-bindings: ARM: brcmstb: Update Broadcom STB Power Management
    binding
  dt-bindings: Document MIPS Broadcom STB power management nodes

Justin Chen (1):
  soc bcm: brcmstb: Add support for S2/S3/S5 suspend states (MIPS)

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   6 +-
 .../devicetree/bindings/mips/brcm/soc.txt          | 153 ++++
 drivers/soc/bcm/Kconfig                            |   2 +
 drivers/soc/bcm/brcmstb/Kconfig                    |   9 +
 drivers/soc/bcm/brcmstb/Makefile                   |   1 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   3 +
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 113 +++
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 836 +++++++++++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm-mips.c               | 461 ++++++++++++
 drivers/soc/bcm/brcmstb/pm/pm.h                    |  89 +++
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  76 ++
 drivers/soc/bcm/brcmstb/pm/s2-mips.S               | 200 +++++
 drivers/soc/bcm/brcmstb/pm/s3-mips.S               | 146 ++++
 13 files changed, 2094 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig
 create mode 100644 drivers/soc/bcm/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-mips.c
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s2-mips.S
 create mode 100644 drivers/soc/bcm/brcmstb/pm/s3-mips.S

-- 
2.9.3
