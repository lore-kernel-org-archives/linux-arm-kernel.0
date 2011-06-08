From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  8 Jun 2011 16:28:29 +0100
Subject: [PATCH 0/2] ARM PMU reservation cleanup
Message-ID: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches clean up the PMU reservation framework to separate the
core logic from modifications required to add FDT support.

This refactoring may require trivial changes to LTTng.

Mark Rutland (2):
  ARM: pmu: refactor reservation
  ARM: pmu: reject duplicate PMU registrations

 arch/arm/include/asm/pmu.h   |    2 +-
 arch/arm/kernel/perf_event.c |    4 ++--
 arch/arm/kernel/pmu.c        |   39 ++++++++++++++++++++++-----------------
 3 files changed, 25 insertions(+), 20 deletions(-)
