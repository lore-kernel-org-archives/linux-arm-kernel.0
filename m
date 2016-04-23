From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 23 Apr 2016 11:43:58 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
Message-ID: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

these two patches move the ARM character LCD driver from
misc drivers to the auxdisplay subsystem where it belongs and
updates the defconfig for the RealView accordingly.

Please pull it into some cleanup branch in the ARM SoC
tree.

I tried to get some ACK from the auxdisplay maintainer but no
reaction.

Yours,
Linus Walleij

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/move-auxdisplay

for you to fetch changes up to 700ce70081d4f5ac7bc4fbfba209072152f96c89:

  ARM: realview: update defconfig to match new subsystem (2016-04-23
11:38:25 +0200)

----------------------------------------------------------------
This moves the ARM RealView auxilary display out of
the misc drivers and into the new auxdisplay subsystem.

----------------------------------------------------------------
Linus Walleij (2):
      auxdisplay: move the ARM LCD driver into auxdisplay
      ARM: realview: update defconfig to match new subsystem

 arch/arm/configs/realview_defconfig        |  3 ++-
 drivers/auxdisplay/Kconfig                 | 10 ++++++++++
 drivers/auxdisplay/Makefile                |  1 +
 drivers/{misc => auxdisplay}/arm-charlcd.c |  0
 drivers/misc/Kconfig                       | 10 ----------
 drivers/misc/Makefile                      |  1 -
 6 files changed, 13 insertions(+), 12 deletions(-)
 rename drivers/{misc => auxdisplay}/arm-charlcd.c (100%)
