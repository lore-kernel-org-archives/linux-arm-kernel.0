From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 10:17:52 +0100
Subject: [RFC 0/2] clocksource: don't suspend/resume when unused
Message-ID: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a quite naive implementation to track whether a cloccksource is enabled.
I chose not to add a member in struct clocksource and use a flag instead.

I found that timekeeping.c is the only consumer for clocksource and I converted
it to use clocksource_enable and clocksource_disable.

Regards,

Alexandre Belloni (2):
  clocksource: track usage
  clocksource: don't suspend/resume when unused

 include/linux/clocksource.h |  4 ++++
 kernel/time/clocksource.c   | 30 ++++++++++++++++++++++++++++--
 kernel/time/timekeeping.c   |  8 +++-----
 3 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.1.0
