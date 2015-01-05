From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 5 Jan 2015 12:14:37 +0100
Subject: [GIT PULL] at91: fixes for 3.19 #1 (bis)
Message-ID: <1420456477-18204-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is the rebase of my previous pull-request on top of 3.19-rc1. As said at
the time of my early messages, I was waiting for the arm-soc *and* pinctrl
material to reach Linus T.'s tree before sending this pull-request. In fact
this sequence was needed for the gpio header removal. The little patch about
#include deletion just follows an earlier merge conflict in arm-soc tree: I was
also waiting for this moment before sending the definitive fix, just to be
sure.

In comparison with the previous pull-request, I also added a tiny correction of
the sama5d4.dtsi timer entry. All the rest is pretty straightforward.

Thanks, best regards,

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-fixes

for you to fetch changes up to 0e049c66ebf56a415cadd6c593b7ee0a2cb9d19d:

  ARM: at91/dt: sama5d4: fix the timer reg length (2015-01-05 11:07:14 +0100)

----------------------------------------------------------------
First fixes batch for AT91 on 3.19 folowing The big cleanup:
- removal of unused Kconfig RTC options
- GPIO header file is now in same directory as the pinctrl driver
- little fix on #includes
- removal of DEBUG_LL from the sama5 common defconfig
- little fix of reg size in sama5d4.dtsi

----------------------------------------------------------------
Bo Shen (1):
      ARM: at91/dt: sama5d4: fix the timer reg length

Boris Brezillon (1):
      ARM: at91: remove useless header file includes

Maxime Ripard (1):
      ARM: at91/config: sama5: Remove DEBUG_LL

Nicolas Ferre (2):
      rtc: at91/Kconfig: remove useless options
      ARM: at91: remove unneeded header file

 arch/arm/boot/dts/sama5d4.dtsi             |  2 +-
 arch/arm/configs/sama5_defconfig           |  2 -
 arch/arm/mach-at91/at91sam9g45.c           |  1 -
 arch/arm/mach-at91/at91sam9rl.c            |  1 -
 arch/arm/mach-at91/include/mach/at91_pio.h | 80 ------------------------------
 drivers/rtc/Kconfig                        | 28 -----------
 6 files changed, 1 insertion(+), 113 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_pio.h

-- 
Nicolas Ferre
