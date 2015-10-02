From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  2 Oct 2015 15:20:58 -0700
Subject: [GIT PULL] Broadcom soc changes for v4.4
In-Reply-To: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
References: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.4/soc

for you to fetch changes up to 7333ecdcd71fbbed1e2cab675fd129ab99f4db41:

  ARM: brcmstb: Setup BIU control registers during boot (2015-09-18 12:21:17 -0700)

----------------------------------------------------------------
This pull request contains the following Broadcom SoC platform and driver changes:

- Brian Norris create a drivers/soc/brcmstb/ stub and then adds support for S2/S3/S5
  suspend/resume modes for the Broadcom BCM7xxx Set Top Box SoCs

- Florian Fainelli adds support for configuring the BCM7xxx SoCs Bus Interface Unit
  with their specific write-pairing setting, which must be saved and restored during
  system-wide suspend/resume, and consequently updates the brcmstb machine code to
  initialize the BIU

- Jon Mason adds support for the Northstar Plus SoCs by introducing a custom machine
  descriptor matching their compatible string and setting up the PL310 L2 cache and
  enabling the relevant ARM errata for their Cortex-A9

----------------------------------------------------------------
Brian Norris (2):
      soc: add stubs for brcmstb SoC's
      soc: brcmstb: add PM suspend/resume support (S2/S3/S5)

Florian Fainelli (2):
      soc: brcmstb: Add Bus Interface Unit control setup
      ARM: brcmstb: Setup BIU control registers during boot

Jon Mason (1):
      ARM: NSP: Add basic support for Broadcom Northstar Plus SoC

 arch/arm/mach-bcm/Kconfig           |  15 ++
 arch/arm/mach-bcm/Makefile          |   5 +-
 arch/arm/mach-bcm/bcm_nsp.c         |  25 ++
 arch/arm/mach-bcm/brcmstb.c         |   9 +
 drivers/soc/Kconfig                 |   1 +
 drivers/soc/Makefile                |   1 +
 drivers/soc/brcmstb/Kconfig         |  19 ++
 drivers/soc/brcmstb/Makefile        |   3 +
 drivers/soc/brcmstb/biuctrl.c       | 116 ++++++++
 drivers/soc/brcmstb/common.c        |  33 +++
 drivers/soc/brcmstb/pm/Makefile     |   2 +
 drivers/soc/brcmstb/pm/aon_defs.h   |  85 ++++++
 drivers/soc/brcmstb/pm/pm.c         | 512 ++++++++++++++++++++++++++++++++++++
 drivers/soc/brcmstb/pm/pm.h         |  40 +++
 drivers/soc/brcmstb/pm/s2.S         |  73 +++++
 include/linux/soc/brcmstb/brcmstb.h |  10 +
 include/soc/brcmstb/common.h        |  15 ++
 17 files changed, 963 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm_nsp.c
 create mode 100644 drivers/soc/brcmstb/Kconfig
 create mode 100644 drivers/soc/brcmstb/Makefile
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 drivers/soc/brcmstb/common.c
 create mode 100644 drivers/soc/brcmstb/pm/Makefile
 create mode 100644 drivers/soc/brcmstb/pm/aon_defs.h
 create mode 100644 drivers/soc/brcmstb/pm/pm.c
 create mode 100644 drivers/soc/brcmstb/pm/pm.h
 create mode 100644 drivers/soc/brcmstb/pm/s2.S
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h
 create mode 100644 include/soc/brcmstb/common.h
