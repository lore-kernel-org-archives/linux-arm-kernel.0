From: eric@anholt.net (Eric Anholt)
Date: Fri,  6 Oct 2017 15:05:03 -0700
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
Message-ID: <20171006220504.7776-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian.  Here's a patch that's gone through a couple of revisions
on the list, that seriously fixes up the default serial behavior --
previously, without the right config.txt/cmdline bits, you'd often end
up with a hang with no output before booting completed.  It would be
great to get it into 4.14.

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-fixes-2017-10-06

for you to fetch changes up to f08f58a2bf68900a84e782b8c7ad701c0654173c:

  ARM: dts: bcm283x: Fix console path on RPi3 (2017-10-06 13:04:56 -0700)

----------------------------------------------------------------
This pull request brings in a fix for default serial console setup on
RPi3, so it now comes up with no config.txt/cmdline.txt settings in
the firmware.

----------------------------------------------------------------
Loic Poulain (1):
      ARM: dts: bcm283x: Fix console path on RPi3

 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 9 +++------
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts    | 5 +++++
 arch/arm/boot/dts/bcm283x.dtsi           | 7 ++++++-
 3 files changed, 14 insertions(+), 7 deletions(-)
