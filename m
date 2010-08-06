From: samu.p.onkalo@nokia.com (Samu Onkalo)
Date: Fri,  6 Aug 2010 12:17:40 +0300
Subject: [PATCH 0/1] Skip idle loop in case of extreme pm qos latency
Message-ID: <1281086261-23908-1-git-send-email-samu.p.onkalo@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scheduling is prevented most of the time in idle loop. This causes hundreds of
microseconds delays to interrupt thread scheduling even in case of immediate
return from pm_idle. Driver can set pm-qos-requirement to 0 to indicate that
even this level of latency is not tolerated. In such case idle loop just
calls scheduler to get faster response. When CPU is idle, this delay hits all
the time. On a loaded system, delays in interrupt serving are more random and
can be better tolerated by the sensitite HW driver.

Samu Onkalo (1):
  arm: kernel: idle loop pm constraints

 arch/arm/kernel/process.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
