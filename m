From: credmonster@gmail.com (Chris Redmon)
Date: Wed, 12 Apr 2017 22:20:37 -0400
Subject: [PATCH 0/3] Add fault_major, fault_minor page fault trace events
Message-ID: <20170413022040.10156-1-credmonster@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes add common trace events for major and minor page faults,
as well as adding these traces to the arm and arm64 architectures. These
traces offer useful information for determining the source of page faults
in realtime systems, as well as the time penalty for taking a major or
minor page fault.

I made an attempt to minimize the overhead when these tracepoints are not
enabled, but I'm willing to make more changes if desired.

Chris Redmon (3):
  tracing: Introduce traces for major and minor page faults
  arm: Utilize trace events for major and minor page faults
  arm64: Utilize trace events for major and minor page faults

 arch/arm/mm/fault.c          | 14 +++++++
 arch/arm64/mm/fault.c        | 14 +++++++
 include/trace/events/fault.h | 87 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 include/trace/events/fault.h

-- 
2.12.2.599.gcf11a67
