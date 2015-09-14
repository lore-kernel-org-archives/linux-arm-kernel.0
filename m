From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 12:52:46 -0700
Subject: [PATCH 0/3] ARM: brcmstb: Bus Interface Unit support
Message-ID: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for early boot time Bus Interface Unit control
register setup which is required to occur before SMP is brought-up, but needs
to remap registers, so init_irq() is chosen for that.

This builds on top of the 'soc/next' branch at github.com/Broadcom/stblinux

Thanks!

Florian Fainelli (3):
  Documentation: bindings: brcmstb: Document write-pairing
  soc: brcmstb: Add Bus Interface Unit control setup
  ARM: brcmstb: Setup BIU control registers during boot

 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |  15 +++
 arch/arm/mach-bcm/brcmstb.c                        |   9 ++
 drivers/soc/brcmstb/Makefile                       |   2 +-
 drivers/soc/brcmstb/biuctrl.c                      | 117 +++++++++++++++++++++
 include/linux/soc/brcmstb/brcmstb.h                |  10 ++
 5 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/brcmstb/biuctrl.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb.h

-- 
2.1.0
