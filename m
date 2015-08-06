From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Aug 2015 16:50:13 +0200
Subject: [GIT PULL] Nomadik improvements and cleanups for v4.3
Message-ID: <CACRpkdbN6ZDhH56PSUmPD5_uYJhk_o+mCqAvi5GVEtys=AftNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these are a four patches of Nomadik cleanups and improvements
targeted for v4.2.

Since there is a cross-dependency between the board files and the
device tree files I just kept them all on the same branch. Also it seems
a bit overzealous to split patches for this small platform.

Please pull it in as cleanup/development for v4.3.

Yours,
Linus Walleij

The following changes since commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:

  Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nmk-for-4.3-asoc

for you to fetch changes up to 8c6870b07dd20be91fa4f15fbfcbde75a4dccd28:

  ARM: nomadik: push accelerometer down to boards (2015-08-06 11:24:55 +0200)

----------------------------------------------------------------
Nomadik improvements and cleanups for v4.3:
- Get rid of some custom code and device tree oddities
  that were just placeholders for our now in-kernel
  GPIO hogs.
- Enable UART0 (connected to bluetooth on NHK15)
  selectively on the board, according to reference design
  specs.
- Do the cache AUX register setup in the device tree so
  we understand what is going on.
- Push registration of accelerometers down to the board
  files.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: nomadik: move hog code to use DT hogs
      ARM: nomadik: selectively enable UART0 on boards
      ARM: nomadik: move l2x0 setup to device tree
      ARM: nomadik: push accelerometer down to boards

 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 39 ++++++++++++++++++++------
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 44 ++++++++++++++++++++++++------
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 22 +++++----------
 arch/arm/mach-nomadik/cpu-8815.c           | 41 ++--------------------------
 4 files changed, 75 insertions(+), 71 deletions(-)
