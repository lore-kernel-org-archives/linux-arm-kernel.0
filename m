From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Aug 2017 21:08:32 +0800
Subject: [GIT PULL] i.MX fixes for 4.13, round 2
Message-ID: <20170805130830.GV31819@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 05969566e6d64113a861adc6c17cbba685c640b3:

  ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct location (2017-07-16 09:43:04 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.13-2

for you to fetch changes up to 8317562097acec4c9e9750eb91115687931bca35:

  ARM: dts: i.MX25: add ranges to tscadc (2017-08-05 13:22:32 +0800)

----------------------------------------------------------------
i.MX fixes for 4.13, round 2:
 - Add missing 'ranges' property for i.MX25 device tree TSCADC node, so
   that it's child nodes ADC and TSC device can be probed by kernel.
 - Fix i.MX GPCv2 power domain driver to request regulator after power
   domain initialization, since regulator could defer probing and
   therefore cause power domain initialized twice.

----------------------------------------------------------------
Martin Kaiser (1):
      ARM: dts: i.MX25: add ranges to tscadc

Stefan Agner (1):
      soc: imx: gpcv2: fix regulator deferred probe

 arch/arm/boot/dts/imx25.dtsi |  1 +
 drivers/soc/imx/gpcv2.c      | 15 ++++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)
