From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 May 2014 12:25:46 -0600
Subject: [GIT PULL 3/3] ARM: tegra: defconfig updates for 3.16
In-Reply-To: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
References: <1400264746-13106-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1400264746-13106-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT24C EEPROM:

This is used for the board ID EEPROM on Jetson TK1, as well as likely
a whole slew of other NVIDIA reference boards; we simply haven't added
enabled the EEPROM in the DT files until now.

MTD_SPI_NOR:

This defconfig contains the CONFIG_M25P80 symbol, which is now
dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
the new dependency.

FRAMEBUFFER_CONSOLE_ROTATION:

Needed for devices like Tegra Note 7 and NVIDIA SHIELD to get the boot
console in the expected orientation.

CAN*, RTC_DRV_DS1307:

Toradex Colibri Evaluation Board uses the DS1307 RTC and the MCP251x CAN
controller. The NVIDIA Tegra 3 based Colibri T30 module can be used on
this carrier board.

Furthermore the NVIDIA Tegra 3 based Apalis T30 module too contains two
MCP251x CAN controllers.

INPUT_JOYDEV:

NVIDIA SHIELD embeds a USB joystick device.

----------------------------------------------------------------

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.16-defconfig

for you to fetch changes up to 9956dcc5d136248a415234381311543c8cdf869a:

  ARM: tegra: tegra_defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: tegra: tegra_defconfig updates

 arch/arm/configs/tegra_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
