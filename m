From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 16:05:49 +0800
Subject: [GIT PULL 3/3] ZTE arm64 device tree changes for 4.14
In-Reply-To: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
References: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1503043549-13232-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.14

for you to fetch changes up to 5470964f8c7b9f0b1e1d5eed49a283be0121ac0e:

  arm64: dts: zte: add initial zx296718-pcbox board support (2017-08-14 09:51:16 +0800)

----------------------------------------------------------------
ZTE arm64 device tree updates for 4.14:
 - A clean up patch from Shawn Lin to remove the deprecated dwmmc
   property 'num-slots' from ZX296718 device tree.
 - Enable various devices for ZX296718 SoC support, VGA display, I2S
   audio, pinctrl, GPIO, PWM and IRDEC.
 - Update zx296718-evb support to use audio-graph-card for HDMI audio
   and add I2S sound card.
 - Add initial zx296718-pcbox board support with storage, audio,
   display devices enabled.

----------------------------------------------------------------
Shawn Guo (10):
      arm64: dts: zx296718: add VGA device support
      arm64: dts: zx296718: add I2S and I2C audio codec
      arm64: dts: zx296718: add pinctrl and gpio devices
      arm64: dts: zx296718: set a better parent clock for I2S0
      arm64: dts: zx296718: add voltage data into OPP table
      arm64: dts: zx296718: add PWM device support
      arm64: dts: zx296718: add irdec device for remote control
      arm64: dts: zx296718-evb: use audio-graph-card for HDMI audio
      arm64: dts: zx296718-evb: add I2S sound card support
      arm64: dts: zte: add initial zx296718-pcbox board support

Shawn Lin (1):
      arm64: dts: zte: remove num-slots from zx296718

 arch/arm64/boot/dts/zte/Makefile           |   1 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts   |  68 ++++++++++--
 arch/arm64/boot/dts/zte/zx296718-pcbox.dts | 143 ++++++++++++++++++++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi      | 171 ++++++++++++++++++++++++++++-
 4 files changed, 373 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-pcbox.dts
