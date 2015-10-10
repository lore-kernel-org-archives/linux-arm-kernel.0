From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 10 Oct 2015 11:40:29 -0700
Subject: [GIT PULL] Broadcom soc changes for v4.4 (try 2)
In-Reply-To: <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
References: <1443824458-20799-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <1444502429-11100-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.4/soc

for you to fetch changes up to c4a8ea9e0698945b182ba1e1063a0981b1f35139:

  ARM: brcmstb: Setup BIU control registers during boot (2015-10-09 13:42:18 -0700)

----------------------------------------------------------------
This pull request contains the following Broadcom SoC platform and driver changes:

- Brian Norris create a drivers/soc/brcmstb/ stub as a place holder for SoC-specific
  code which is coming next

- Florian Fainelli adds support for configuring the BCM7xxx SoCs Bus Interface Unit
  with their specific write-pairing setting, which must be saved and restored during
  system-wide suspend/resume, and consequently updates the brcmstb machine code to
  initialize the BIU

- Jon Mason adds support for the Northstar Plus SoCs by introducing a custom machine
  descriptor matching their compatible string and setting up the PL310 L2 cache and
  enabling the relevant ARM errata for their Cortex-A9

----------------------------------------------------------------
Brian Norris (1):
      soc: add stubs for brcmstb SoC's

Florian Fainelli (2):
      soc: brcmstb: Add Bus Interface Unit control setup
      ARM: brcmstb: Setup BIU control registers during boot

Jon Mason (1):
      ARM: NSP: Add basic support for Broadcom Northstar Plus SoC

 arch/arm/mach-bcm/Kconfig           |  15 +++++
 arch/arm/mach-bcm/Makefile          |   5 +-
 arch/arm/mach-bcm/bcm_nsp.c         |  25 ++++++++
 arch/arm/mach-bcm/brcmstb.c         |   9 +++
 drivers/soc/Kconfig                 |   1 +
 drivers/soc/Makefile                |   1 +
 drivers/soc/brcmstb/Kconfig         |   9 +++
 drivers/soc/brcmstb/Makefile        |   1 +
 drivers/soc/brcmstb/biuctrl.c       | 116 ++++++++++++++++++++++++++++++++++++
 drivers/soc/brcmstb/common.c        |  33 ++++++++++
 include/linux/soc/brcmstb/brcmstb.h |  10 ++++
 include/soc/brcmstb/common.h        |  15 +++++
 12 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm_nsp.c
 create mode 100644 drivers/soc/brcmstb/Kconfig
 create mode 100644 drivers/soc/brcmstb/Makefile
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 drivers/soc/brcmstb/common.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h
 create mode 100644 include/soc/brcmstb/common.h
