From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Nov 2010 16:38:20 -0000
Subject: [PATCH v2] ARM: perf: split up perf_event.c by architecture
Message-ID: <000a01cb8a63$ac5c8110$05158330$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 2 of the patches originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/031503.html

The only patch that has changed is 5/5 which addresses some style comments
raised by Jean. Since the patch is over 100k, I've put it in my git repository
rather than posting it to the list (where it would be held for moderation).

Feedback welcome.


The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:
  Linus Torvalds (1):
        Linux 2.6.37-rc3

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git perf-split

Will Deacon (5):
      ARM: perf: consolidate common PMU behaviour
      ARM: perf: avoid exposing internal stop function for v6 PMU
      ARM: perf: add _init() functions to PMUs
      ARM: perf: encode PMU name in arm_pmu structure
      ARM: perf: separate PMU backends into multiple files

 arch/arm/kernel/perf_event.c        | 2448 +----------------------------------
 arch/arm/kernel/perf_event_v6.c     |  672 ++++++++++
 arch/arm/kernel/perf_event_v7.c     |  906 +++++++++++++
 arch/arm/kernel/perf_event_xscale.c |  807 ++++++++++++
 4 files changed, 2419 insertions(+), 2414 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event_v6.c
 create mode 100644 arch/arm/kernel/perf_event_v7.c
 create mode 100644 arch/arm/kernel/perf_event_xscale.c
