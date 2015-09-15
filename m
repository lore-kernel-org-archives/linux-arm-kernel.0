From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Sep 2015 11:14:57 -0700
Subject: [PATCH v2 0/3] ARM: brcmstb: Bus Interface Unit support
Message-ID: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for early boot time Bus Interface Unit control
register setup which is required to occur before SMP is brought-up, but needs
to remap registers, so init_irq() is chosen for that.

This builds on top of the 'soc/next' branch at github.com/Broadcom/stblinux

Major changes in v2:

- updated Device Tree documentation based on Rob's feedback
- added a better pr_fmt format for pr_* calls in biuctrl.c

Florian Fainelli (3):
  Documentation: bindings: brcmstb: Document write-pairing
  soc: brcmstb: Add Bus Interface Unit control setup
  ARM: brcmstb: Setup BIU control registers during boot

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |  20 ++++
 arch/arm/mach-bcm/brcmstb.c                        |   9 ++
 drivers/soc/brcmstb/Makefile                       |   2 +-
 drivers/soc/brcmstb/biuctrl.c                      | 119 +++++++++++++++++++++
 include/linux/soc/brcmstb/brcmstb.h                |  10 ++
 5 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h

-- 
2.1.0
