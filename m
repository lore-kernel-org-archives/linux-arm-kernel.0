From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  8 Jul 2013 09:51:36 -0700
Subject: [PATCH v2 0/2] clocksource/cadence_ttc: Add sched_clock functionality
Message-ID: <1373302298-27957-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I updated the original patch according to the discussion with Thomas and Baruch.
Furthermore, I noticed that the driver includes the clk-provider header for no
apparent reason and removed it.

	S?ren

v2:
 - adding patch to remove unused header to the series
 - #include linux/sched_clock.h instead of asm/sched_clock.h
 - remove Kconfig options and #ifdefs around sched_clock related code
    The reasons for having those are obsolete, since ARM deprecated its
    custom sched_clock framework and migrated to the common one.


Soren Brinkmann (2):
  clocksource/cadence_ttc: Remove unused header
  clocksource/cadence_ttc: Reuse clocksource as sched_clock

 drivers/clocksource/cadence_ttc_timer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
1.8.3.2
