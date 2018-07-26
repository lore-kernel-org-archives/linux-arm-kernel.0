From: joel@jms.id.au (Joel Stanley)
Date: Thu, 26 Jul 2018 14:03:11 +0930
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 4.19
Message-ID: <CACPK8XdcAANiSwsvCnu249W8QcFfjP616ce-YOW=UohgpTHtVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello ARM Maintainers,

Here are the ASPEED defconfig updates for 4.19. It's been a while since I sent
one, so this contains a lot of goodies.

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.19-defconfig

for you to fetch changes up to 90708adcd3ead258d4c2185da6acbe748eb0cc32:

  ARM: config: aspeed: Enable new FSI drivers (2018-07-26 13:27:27 +0930)

----------------------------------------------------------------
ASPEED defconfig updates for 4.19

 - Refresh the multi ARMv5 defconfig, and add AST2400 related drivers

 - Enable new ASPEED hardware that we've merged in the past few cycles.
 There are about 14 different drivers since we last refreshed the
 defconfig

 - Turn on features required by systemd, and other bits of OpenBMC
 userspace

 - Enable security related options

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      arm: configs: Add USB gadget to Aspeed G4 defconfig
      arm: configs: Add USB gadget to Aspeed G5 defconfig

Joel Stanley (4):
      ARM: config: aspeed: Update defconfig
      ARM: config: multi_v5: Refresh configuration
      ARM: config: multi_v5: Enable ASPEED drivers
      ARM: config: aspeed: Enable new FSI drivers

 arch/arm/configs/aspeed_g4_defconfig | 113 ++++++++++++++++++++++++++++-----
 arch/arm/configs/aspeed_g5_defconfig | 117 +++++++++++++++++++++++++++++------
 arch/arm/configs/multi_v5_defconfig  |  30 +++++----
 3 files changed, 213 insertions(+), 47 deletions(-)
