From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 23:31:36 +0200
Subject: [PATCH 0/5] pinctrl: berlin: clean up
Message-ID: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus, Sebastian,

This series has a few patches to clean up a bit the Berlin pinctrl
drivers. The main modification is to move the pinctrl driver selection
from mach-berlin to drivers/pinctrl/berlin. Then a missing dependency
is added and finally the last 2 patches are cosmetics.

This series depends on the series submitted by Jisheng some days ago [1].

Thanks!

Antoine

[1] https://lkml.org/lkml/2015/10/9/278

Antoine Tenart (5):
  pinctrl: berlin: select the pinctrl driver according to the SoC used
  ARM: berlin: remove the pinctrl selection from the mach-berlin Kconfig
  pinctrl: berlin: add explicit dependency on OF
  pinctrl: berlin: Kconfig clean up
  pinctrl: berlin: fix my family name spelling

 arch/arm/mach-berlin/Kconfig          |  3 ---
 drivers/pinctrl/berlin/Kconfig        | 11 +++++++----
 drivers/pinctrl/berlin/berlin-bg2.c   |  4 ++--
 drivers/pinctrl/berlin/berlin-bg2cd.c |  4 ++--
 drivers/pinctrl/berlin/berlin-bg2q.c  |  4 ++--
 drivers/pinctrl/berlin/berlin.c       |  2 +-
 drivers/pinctrl/berlin/berlin.h       |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.6.1
