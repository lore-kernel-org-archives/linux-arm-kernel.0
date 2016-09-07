From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Sep 2016 18:59:15 -0700
Subject: [GIT PULL 1/4] Broadcom soc changes for 4.9
Message-ID: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/soc

for you to fetch changes up to 4ebd50472899eb07d5dfc24f2015dce6fe3c5cb8:

  ARM: BCM53573: Initial support for Broadcom BCM53573 SoCs (2016-08-22 15:58:27 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC changes for 4.9, please pull
the following:

- Rafal adds preliminary support for the new BCM53573 Wi-Fi SoC based on a
  single core Cortex A7 and re-using a bunch of iProc peripherals

- Florian adds support for earlyprintk on Broadcom STB/CM ARM-based chips by
  reading the chip family_id value from a known location and deriving the UART
  based address

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: brcmstb: Add earlyprintk support using run-time checks

Rafa? Mi?ecki (1):
      ARM: BCM53573: Initial support for Broadcom BCM53573 SoCs

 MAINTAINERS                      |   7 ++
 arch/arm/Kconfig.debug           |  14 ++--
 arch/arm/include/debug/brcmstb.S | 145 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig        |  14 ++++
 arch/arm/mach-bcm/brcmstb.c      |  16 +++++
 5 files changed, 189 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/debug/brcmstb.S
