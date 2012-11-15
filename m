From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Thu, 15 Nov 2012 22:23:52 +0530
Subject: [RFC v2 PATCH 0/2] sched: Integrating Per-entity-load-tracking with
 the core scheduler
Message-ID: <20121115164730.17426.36051.stgit@preeti.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This approach aims to retain the current behavior of load balancer with the
change being only in the metric consumed during load balancing,
without unnecessary introduction of new variables.This RFC has been posted to
evaluate its design;to see if this is the right way to go about introducing
per-entity-load-tracking metric for the consumers of the same; in this
specific case,the load balancer.Once the design has been approved off,I can
go around to testing it.

The patch has been based out of tip-master:HEAD at commit 8a1d31c703d
Subject:Merge branch 'x86/urgent'

Grateful to Peter Zijlstra and Ingo Molnar for their valuable feedback on v1
of the RFC which was the foundation for this version.

PATCH[1/2] Aims at enabling usage of Per-Entity-Load-Tracking for load balacing
PATCH[2/2] The crux of the patchset lies here.
---

Preeti U Murthy (2):
      sched: Revert temporary FAIR_GROUP_SCHED dependency for load-tracking
      sched: Use Per-Entity-Load-Tracking metric for load balancing


 include/linux/sched.h |    9 +-----
 kernel/sched/core.c   |   19 +++++-------
 kernel/sched/fair.c   |   76 +++++++++++++++++++++----------------------------
 kernel/sched/sched.h  |    9 +-----
 4 files changed, 43 insertions(+), 70 deletions(-)

-- 
Preeti U Murthy
