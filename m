From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  2 Nov 2014 16:16:52 +0100
Subject: [PATCH v1 0/3] Transition pxa25x clock to common clocks
Message-ID: <1414941415-13146-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello pxa25x board maintainers,

This patchset will move the clock code out of pxa subarchitecture into the
common clock framework. As this change can bring a lot of regression, I'd like
to test it on your boards.

I prepared for you a git tree based on v3.18-rc :
 - git fetch https://github.com:rjarzmik/linux.git work/clocks-pxa:try
 - git checkout try

 - it contains all the common clock fixes for pxa and this pathset
 - it builds and runs on lubbock (thanks Russell for the board)
 - make your defconfig, kernel, boot
 - test
   - if it does run normally, tell me
   - if it doesn't boot, retry once with the kernel command line argument "clk_ignore_unused" and tell me if it fixed or not the problem
   - be aware of the GPIO11 clock change
     => this is especially true for Ian as my change doesn't look good

If you could give me feedback if it works for you there will be less breakage.

And if you want to give a review, even better.

Cheers.

--
Robert

Robert Jarzmik (3):
  clk: add pxa25x clock drivers
  arm: pxa: Transition pxa25x to clk framework
  ARM: pxa: move gpio11 clock to board files

 arch/arm/Kconfig             |   1 +
 arch/arm/mach-pxa/Makefile   |   9 +-
 arch/arm/mach-pxa/eseries.c  |   5 +-
 arch/arm/mach-pxa/generic.c  |   2 +
 arch/arm/mach-pxa/generic.h  |   1 +
 arch/arm/mach-pxa/lubbock.c  |   3 +
 arch/arm/mach-pxa/pxa25x.c   | 182 ----------------------------
 drivers/clk/pxa/Makefile     |   1 +
 drivers/clk/pxa/clk-pxa25x.c | 274 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 290 insertions(+), 188 deletions(-)
 create mode 100644 drivers/clk/pxa/clk-pxa25x.c

-- 
2.1.0
