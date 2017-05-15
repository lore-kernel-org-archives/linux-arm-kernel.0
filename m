From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 15 May 2017 23:44:56 +0900
Subject: [GIT PULL] ARM: uniphier: UniPhier fixes for v4.12
Message-ID: <CAK7LNAST-GjDVNGMuCPEo77D1DFiPpJRztbV-XsnjUfD1iWf=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are some ARM UniPhier SoC fixes for v4.12.
Due to the eMMC driver update, PHY parameters must be specified
via DT to make the eMMC controller work again.
The rest is DTC warning fixes reported when building DT with W=1.
Please pull!


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-fixes-v4.12

for you to fetch changes up to 96abf9ded7954d9e6f3a7775353d9550b1283db9:

  arm64: dts: uniphier: fix simple-bus unit address format error
(2017-05-14 11:43:46 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.12

- add necessary DT properties to get eMMC work again
- fix DTC warnings when compiled with W=1

----------------------------------------------------------------
Masahiro Yamada (4):
      arm64: dts: uniphier: add input-delay properties to Cadence eMMC node
      arm64: dts: uniphier: add cdns, phy-dll-delay-sdclk(-hsmmc) for eMMC
      ARM: dts: uniphier: fix simple-bus unit address format error
      arm64: dts: uniphier: fix simple-bus unit address format error

Viresh Kumar (2):
      ARM: uniphier: Use - instead of @ for DT OPP entries
      arm64: uniphier: Use - instead of @ for DT OPP entries

 arch/arm/boot/dts/uniphier-ld4.dtsi              |  2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi             |  2 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi             | 34 ++++++++++-----------
 arch/arm/boot/dts/uniphier-pxs2.dtsi             | 18 +++++------
 arch/arm/boot/dts/uniphier-sld3.dtsi             |  2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi             |  2 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi     |  4 +--
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 21 ++++++++-----
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 39 +++++++++++++-----------
 9 files changed, 67 insertions(+), 57 deletions(-)


-- 
Best Regards
Masahiro Yamada
