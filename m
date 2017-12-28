From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Dec 2017 14:30:44 +0800
Subject: [GIT PULL 2/3] Allwinner DT64 changes for 4.16
In-Reply-To: <20171228062444.GA3883@wens.csie.org>
Message-ID: <20171228063044.GA4103@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.16

for you to fetch changes up to 36252668c14ca14691d40c3455849ac5d8a60b62:

  arm64: dts: allwinner: a64: bananapi-m64: Add LED device node (2017-12-08 10:39:53 +0100)

----------------------------------------------------------------
Allwinner DT64 changes for 4.16

There are two important changes in this round.

The first removes the redundant pinctrl setting for the MMC card detect
GPIO. We are moving to strict pinctrl/GPIO exclusion, i.e. GPIO usage
will block other pin muxing usage, and vice versa. The usage of pinmux
for guarding GPIO pins in the device tree prevents us from doing so.
This is part of an ongoing effort to clean up the existing device trees.

The other important change enables the PMIC on the Orangepi Win. The
PMIC provides power to most of the external onboard peripherals.
Enabling it will allow us to enable Ethernet or WiFi support later on.

The remaining changes in this round enable some peripheral, such as
Ethernet, an external WiFi chip, or LEDs.

----------------------------------------------------------------
Andre Przywara (1):
      arm64: dts: allwinner: H5: remove redundant MMC0 card detect pin

Antony Antony (1):
      arm64: dts: allwinner: h5: NanoPi NEO Plus2 : add EMAC support

Chen-Yu Tsai (1):
      arm64: dts: allwinner: a64: bananapi-m64: Add LED device node

Jagan Teki (2):
      arm64: allwinner: a64: Enable AXP803 for Orangepi Win
      arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi

Sergey Matyukevich (1):
      arm64: dts: orange-pi-zero-plus2: enable AP6212a WiFi/BT combo

 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |  36 ++++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |  23 ++++
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 125 +++++++++++++++++++--
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |  19 +++-
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |   2 +-
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   2 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |   2 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  34 +++++-
 8 files changed, 230 insertions(+), 13 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/edacd10a/attachment.sig>
