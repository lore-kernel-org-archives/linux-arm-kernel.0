From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 16:07:52 -0300
Subject: [PATCH 0/2] Marvell Armada 375 and 38x timer support
Message-ID: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

This small series adds support for the two new Marvell ARM SoCs:
the Armada 375 and Armada 38x.

These new SoCs are based on Cortex-A9 CPU cores, and share a
number of peripherals with their predecessors in the mach-mvebu
family. The core support (arch/arm/mach-mvebu) for these SOCs have just
been posted, and we're aiming at having this merged for 3.15.

The A375 SoC timer is modeled matching the A370 timer, while the
A38x SoC timer is modeled matching the AXP timer. However, we'd like
to keep the compatible strings as SoC-specific.

In the past, we've had trouble chosing a common compatible string, resulting
in the introduction of per-SoC compatibles. Such compatible-string change
of course implies breaking backards compatibility, and was only possible
after agreeing that the old compatible wasn't used in production.

So, in order to avoid such problems, we think it's better to keep them
separate.

Gregory CLEMENT (2):
  clocksource: armada-370-xp: Add support for Armada 375
  clocksource: armada-370-xp: Add support for Armada 38x

 .../bindings/timer/marvell,armada-370-xp-timer.txt | 13 ++++++++----
 drivers/clocksource/time-armada-370-xp.c           | 23 +++++++++++++++++++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
1.8.1.5
