From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Feb 2016 10:49:38 +0100
Subject: [GIT PULL] RealView defconfig reduction
Message-ID: <CACRpkdYUPFm=s6mZbU8xTHqQBtcvmdCzaTCfSBPfBQ1qQi2f5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this cuts the RealView SMP-specific defconfig. It is just confusing and
hard to handle now that we can do SMP on UP.

Tested on RealView PB11MPcore (SMP) and PB1176JZF-S (UP).

I don't know if people's autobuild systems are made to handled the case
where a defconfig disappears, so heads up to Kevin & Olof.

Please pull this in for this or the next kernel cycle whatever suits you
best.

Yours,
Linus Walleij

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-defconfig-redux

for you to fetch changes up to 52abf1eff88d291c5ba092dc93fc8065efd94236:

  ARM: realview: enable USB storage in the defconfig (2016-02-09 10:39:38 +0100)

----------------------------------------------------------------
This makes the RealView defconfig select SMP on UP
so we only need one defconfig for RealView, then adds
USB mass storage configuration.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: realview: activate SMP on the default defconfig
      ARM: realview: delete realview-smp_defconfig
      ARM: realview: enable USB storage in the defconfig

 arch/arm/configs/realview-smp_defconfig | 105 --------------------------------
 arch/arm/configs/realview_defconfig     |   5 ++
 2 files changed, 5 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/configs/realview-smp_defconfig
