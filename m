From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 27 Jun 2015 09:25:42 -0700
Subject: [PATCH 0/2] ARM: BCM: Do not select MTD_NAND_BRCMNAND
Message-ID: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This two patches fix a linking failure when ARCH_BCM_IPROC is selected
for the BRCMNAND driver since we end-up selecting this driver without
its proper depdendencies. Instead do not do this select driver which is
user-selectable, but add it to the multi_v7_defconfig.

Let me know if you would prefer a pull request for this rather than
individual patches. Thanks!

Florian Fainelli (2):
  ARM: BCM: Do not select CONFIG_MTD_NAND_BRCMNAND
  ARM: multi_v7_defconfig: Enable BRCMNAND driver

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/mach-bcm/Kconfig           | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.1.0
