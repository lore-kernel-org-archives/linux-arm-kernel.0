From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 6 Dec 2015 23:17:06 +0100
Subject: [GIT PULL v2] at91: fixes for 4.4 #2
Message-ID: <20151206221706.GA25252@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

As discussed with Arnd, there was an issue in the previous pinctrl
selection which is necessary to get sama5d2 to work.

That pull request replaces th previous one sent by Nicolas. His message
was:

"This is the second AT91 "fixes" for 4.4. This one allows the sama5d2 to
properly boot with its PIO4 controller and use one of its main interfaces,
with the 1.8 capable eMMC, on the sama5d2 Xplained reference platform."

Thanks!

The following changes since commit 50cb2efaa63bdfd4a68b94acc55a12e68d9c33d4:

  MAINTAINERS: Atmel drivers: change NAND and ISI entries (2015-11-17 12:08:46 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-4.4-fixes-2

for you to fetch changes up to 8423536fe453b3623f4ed7c2c3cca9b86af1ace5:

  ARM: at91: fix pinctrl driver selection (2015-12-04 18:54:53 +0100)

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
 arch/arm/mach-at91/pm.c                     | 7 ++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151206/7d76dd38/attachment-0001.sig>
