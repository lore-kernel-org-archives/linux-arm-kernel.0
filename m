From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 22:57:58 +0800
Subject: [GIT PULL 2/5] i.MX SoC changes for 4.18
In-Reply-To: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1526828281-14664-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.18

for you to fetch changes up to 0e8d1c4b7613399494720e315f99d21793cacb8c:

  ARM: imx: select imx6sll pinctrl when imx6sll enabled (2018-05-02 15:01:32 +0800)

----------------------------------------------------------------
i.MX SoC update for 4.18:
 - A series from Bartosz to convert all i.MX plaform code using
   at24_platform_data to use at24 eeprom generic device properties.
 - Enable pinctrl driver support for i.MX6SLL SoC.
 - Clean up i.MX platform code using spi_imx platform data on outdated
   documentation and chip select array usage.

----------------------------------------------------------------
Bai Ping (1):
      ARM: imx: select imx6sll pinctrl when imx6sll enabled

Bartosz Golaszewski (4):
      ARM: imx: vpr200: drop at24_platform_data
      ARM: imx: pcm043: use device properties for at24 eeprom
      ARM: imx: pca100: use device properties for at24 eeprom
      ARM: imx: pcm037: use device properties for at24 eeprom

Trent Piepho (1):
      ARM: imx: Update spi_imx platform data to reflect current state

 arch/arm/mach-imx/Kconfig             |  1 +
 arch/arm/mach-imx/mach-mx31_3ds.c     | 18 ++----------------
 arch/arm/mach-imx/mach-mx31lilly.c    | 12 ++----------
 arch/arm/mach-imx/mach-mx31lite.c     | 16 ++--------------
 arch/arm/mach-imx/mach-mx31moboard.c  | 17 +++--------------
 arch/arm/mach-imx/mach-pca100.c       | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm037.c       | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm037_eet.c   |  5 +----
 arch/arm/mach-imx/mach-pcm043.c       | 13 ++++++-------
 arch/arm/mach-imx/mach-vpr200.c       |  9 +--------
 include/linux/platform_data/spi-imx.h | 29 +++++++++++++++++------------
 11 files changed, 47 insertions(+), 99 deletions(-)
