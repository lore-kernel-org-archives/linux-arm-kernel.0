From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 23 Apr 2016 12:59:00 -0700
Subject: [GIT PULL 4/4] Broadcom drivers changes for 4.7
In-Reply-To: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1461441540-5095-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.7/drivers

for you to fetch changes up to b0ec633c28d42281c03b41dbc92a4448a481f2f3:

  bus: brcmstb_gisb: Rework dependencies (2016-04-18 14:20:30 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs drivers changes:

- Justin adds a soc_dev driver to properly report to user-space the Broadcom
  STB SoC family, product and revision

- Florian reworks how the brcmstb_gisb driver dependency is done to enable it
  on Broadcom STB MIPS-based SoCs and remove a select in
  arch/arm/mach-bcm/Kconfig

----------------------------------------------------------------
Florian Fainelli (1):
      bus: brcmstb_gisb: Rework dependencies

Justin Chen (1):
      soc: brcmstb: add SoC driver to brcmstb

 arch/arm/mach-bcm/Kconfig    |  2 +-
 drivers/bus/Kconfig          |  1 +
 drivers/soc/brcmstb/common.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
