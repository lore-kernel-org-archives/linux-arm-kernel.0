From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Dec 2015 12:27:47 +0100
Subject: [GIT PULL] at91: fixes for 4.4 #2
Message-ID: <1449055667-15843-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the second AT91 "fixes" for 4.4. This one allows the sama5d2 to
properly boot with its PIO4 controller and use one of its main interfaces,
with the 1.8 capable eMMC, on the sama5d2 Xplained reference platform.

Thanks, best regards,

The following changes since commit 50cb2efaa63bdfd4a68b94acc55a12e68d9c33d4:

  MAINTAINERS: Atmel drivers: change NAND and ISI entries (2015-11-17 12:08:46 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes2

for you to fetch changes up to da71bac1b67344174294f9671dd8691cfd486782:

  ARM: at91: fix pinctrl driver selection (2015-12-02 11:09:38 +0100)

----------------------------------------------------------------
Second fixes for 4.4:
- fix of a hardware setup that prevents the sd/mmc interface to show up on
  sama5d2.
- proper selection of pinctrl drivers. PIO4 is necessary for the sama5d2 to
  boot.

----------------------------------------------------------------
Ludovic Desroches (1):
      ARM: at91: fix pinctrl driver selection

Nicolas Ferre (1):
      ARM: at91/dt: add always-on to 1.8V regulator

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 arch/arm/mach-at91/Kconfig                  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
Nicolas Ferre
