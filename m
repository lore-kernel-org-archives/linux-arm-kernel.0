From: zlim@broadcom.com (Zi Shen Lim)
Date: Thu, 24 Apr 2014 20:18:40 -0700
Subject: [PATCHv2 0/2] arm64 topology updates
Message-ID: <1398395922-7482-1-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this updated series, I've added Mark Brown's review-by to PATCH 1/2.

I've addressed Mark's comments for PATCH 2/2.
In order not to lose any information from MPIDR bits, we map all
higher affinity levels into "cluster". This approach is similar to
how Mark is handling multi-level clusters in DT.

Many thanks to Mark for review and comments!

Link to initial posting of this series:
    https://lkml.org/lkml/2014/4/22/950

Zi Shen Lim (2):
  arm64, sched: Remove unused mc_capable() and smt_capable()
  arm64: topology: add MPIDR-based detection

 arch/arm64/include/asm/cputype.h  |  2 ++
 arch/arm64/include/asm/topology.h |  3 ---
 arch/arm64/kernel/topology.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
1.8.4.3
