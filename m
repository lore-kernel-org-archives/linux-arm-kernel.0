From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 17:57:17 +0100
Subject: [PATCH v2 0/2] clocksource: don't suspend/resume when unused
Message-ID: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a quite naive implementation to track whether a clocksource is enabled.
I chose not to add a member in struct clocksource and use a flag instead.

I found that timekeeping.c is the only consumer for clocksource and I converted
it to use clocksource_enable and clocksource_disable.

Changes in v2:
 - removed the check on enable in timekeeping.c to ensure all clocksources are
   going through clocksource_enable
 - rework clocksource_enable to set CLOCK_SOURCE_USED when enable is successful
   if present

Alexandre Belloni (2):
  clocksource: track usage
  clocksource: don't suspend/resume when unused

 include/linux/clocksource.h |  4 ++++
 kernel/time/clocksource.c   | 34 ++++++++++++++++++++++++++++++++--
 kernel/time/timekeeping.c   |  8 +++-----
 3 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.1.0
