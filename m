From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Jun 2013 21:56:18 +0200
Subject: [PATCHv2 0/8] clocksource: sunxi: Timer fixes and cleanup
Message-ID: <1372449386-1334-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

The first timer code we merged when adding support for the A13 some
time back was mostly a clean up from the source drop we had, without
any documentation.  This happened to work, but the code merged in
turned out to be far from perfect, and had several flaws.

This patchset hopefully fixes these flaws, and cleanup most of the
driver as well, to end up in an almost complete rewrite of it (even
though it's not that long).

It also finally adds a clocksource from the free running counter found
in the A10/A13 SoCs.

These flaws have all been spotted when trying to add the A31 support,
work that is still ongoing, but will hopefully benefit from this
patchset as well.

Thanks,
Maxime

Changes from v1:
  - Rebased on top of linux-next to benefit from the move to all
    architectures of the sched_clock functions
  - Moved the clock source to the second timer instead of the 64 bits
    free-running counter like suggested by Thomas.

Maxime Ripard (8):
  clocksource: sun4i: Use the BIT macros where possible
  clocksource: sun4i: Add clocksource and sched clock drivers
  clocksource: sun4i: Don't forget to enable the clock we use
  clocksource: sun4i: Fix the next event code
  clocksource: sun4i: Factor out some timer code
  clocksource: sun4i: Remove TIMER_SCAL variable
  clocksource: sun4i: Cleanup parent clock setup
  clocksource: sun4i: Fix bug when switching from periodic to oneshot
    modes

 drivers/clocksource/sun4i_timer.c | 97 ++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 33 deletions(-)

-- 
1.8.3.1
