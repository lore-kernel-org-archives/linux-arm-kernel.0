From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 18:56:14 -0700
Subject: [GIT PULL 6/7] Broadcom defconfig changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1466128575-5378-6-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/defconfig

for you to fetch changes up to 41463c3e6eae3dfa4377069966ed02b4ba378e79:

  ARM: Remove bcm_defconfig (2016-06-16 13:40:49 -0700)

----------------------------------------------------------------
This pull request contains defconfig changes for Broadcom ARM-based SoCs:

- Florian enables support for the BCM63xx DSL SoCs basic peripherals, enables
  the networking subsystems for Set Top Box SoCs, enables the PWM, watchdog and
  the AHCI controller and SATA PHY drivers

- Florian removes the bcm_defconfig file which is no longer useful and updates
  multi_v7_defconfig to include the Kona watchdog to provide proper reboot for the
  Broadcom Kona platforms

Please note that Tejun Heo has queued a patch which renames AHCI_BRCMSTB into
AHCI_BRCM, to avoid two patches in a row, we just enable AHCI_BRCM to be future
proof

----------------------------------------------------------------
Florian Fainelli (7):
      ARM: multi_v7_defconfig: Enable BCM63xx
      ARM: multi_v7_defconfig: Enable BRCMSTB networking
      ARM: multi_v7_defconfig: Enable Broadcom AHCI
      ARM: multi_v7_defconfig: Enable BCM7038 Watchdog
      ARM: multi_v7_defconfig: Enable Broadcom STB PWM
      ARM: multi_v7_defconfig: Enable Broadcom Kona watchdog
      ARM: Remove bcm_defconfig

 arch/arm/configs/bcm_defconfig      | 141 ------------------------------------
 arch/arm/configs/multi_v7_defconfig |  13 ++++
 2 files changed, 13 insertions(+), 141 deletions(-)
 delete mode 100644 arch/arm/configs/bcm_defconfig
