From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 30 Sep 2013 18:48:06 +0200
Subject: [GIT PULL] at91: fixes for 3.12 #2
Message-ID: <1380559686-2605-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Second batch of fixes for AT91. Two little patches but that can be important
for AT91.
One is finishing the conversion to clk_xxx_[un]prepare() routines. That will
allow us to begin the move to common clock framework with help from Boris and
his big patch series. I tried to push it through Thomas and John's git tree but
without success.
The other one is important for sam9g45 when the second DDR conrtoller is in
use. The DDR / EBI lines are not properly reseted after a shutdown and could
prevent the use of whatever is connected to this EBI. It is not a configuration
that we are using on the Evaluation Kit and this explains why we face this isue
just now...

Thanks, best regards,

The following changes since commit 9ceb389dddbcdb87830f01fcf84d94b2da581dae:

  ARM: at91: remove IRQF_DISABLED (2013-09-19 15:36:35 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-fixes

for you to fetch changes up to 93f6319386b1bd57c9937c818bf1de0b81f03271:

  ARM: at91: sam9g45: shutdown ddr1 too when rebooting (2013-09-30 18:24:52 +0200)

----------------------------------------------------------------
2nd fixes series for 3.12
- one TC clocksource enhancement that is the remaining patch that moves to
  clk_xxx_[un]prepare()
- management of second DDR controller for the sam9g45 shutdown. This routine
  also applies to most of other sam9s.

----------------------------------------------------------------
Boris BREZILLON (1):
      ARM: at91/tc/clocksource: replace clk_enable/disable with clk_prepare_enable/disable_unprepare.

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: sam9g45: shutdown ddr1 too when rebooting

 arch/arm/mach-at91/at91sam9g45_reset.S |  8 ++++++++
 drivers/clocksource/tcb_clksrc.c       | 10 +++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
Nicolas Ferre
