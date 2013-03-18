From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:26 +0900
Subject: [GIT PULL] ARM and SH based SoC clocksource update for v3.10
Message-ID: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-for-v3.10

for you to fetch changes up to 342896a5c565e38dfb87954f362735f03ae1efb0:

  clocksource: sh_mtu2: Set initcall level to subsys (2013-03-13 02:24:37 +0900)

----------------------------------------------------------------
Renesas ARM and SH based SoC clocksource update for v3.10

I has been agreed by Paul Mundt and myself, that it would be best to take
these changes through the renesas tree and in turn the arm-soc tree.

----------------------------------------------------------------
Magnus Damm (8):
      clocksource: sh_cmt: Take care of clk_put() when setup_irq() fails
      clocksource: sh_cmt: Initialize 'max_match_value' and 'lock' in sh_cmt_setup()
      clocksource: sh_cmt: Introduce per-register functions
      clocksource: sh_cmt: Consolidate platform_set_drvdata() call
      clocksource: sh_cmt: CMSTR and CMCSR register access update
      clocksource: sh_cmt: CMCNT and CMCOR register access update
      clocksource: sh_cmt: Add control register callbacks
      clocksource: sh_cmt: Add CMT register layout comment

Simon Horman (4):
      clocksource: sh_cmt: Set initcall level to subsys
      clocksource: sh_tmu: Set initcall level to subsys
      clocksource: em_sti: Set initcall level to subsys
      clocksource: sh_mtu2: Set initcall level to subsys

 drivers/clocksource/em_sti.c  |   13 ++-
 drivers/clocksource/sh_cmt.c  |  189 +++++++++++++++++++++++++----------------
 drivers/clocksource/sh_mtu2.c |    2 +-
 drivers/clocksource/sh_tmu.c  |    2 +-
 4 files changed, 132 insertions(+), 74 deletions(-)
