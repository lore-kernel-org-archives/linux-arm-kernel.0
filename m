From: broonie@kernel.org (Mark Brown)
Date: Fri,  2 May 2014 13:38:26 -0700
Subject: [PATCH 0/6] arm64: topology: DT and MPIDR support
Message-ID: <1399063112-16917-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

This reposting of the series rolls together the work from myself and Zi
Shen, it includes the revisions Lorenzo provided on the last round of
review.  It is also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/arm64-topology-dt-mpidr

Mark Brown (4):
  arm64: topology: Initialise default topology state immediately
  arm64: topology: Add support for topology DT bindings
  arm64: topology: Tell the scheduler about the relative power of cores
  arm64: topology: Provide relative power numbers for cores

Zi Shen Lim (2):
  arm64: sched: Remove unused mc_capable() and smt_capable()
  arm64: topology: add MPIDR-based detection

 arch/arm64/include/asm/cputype.h  |   5 +
 arch/arm64/include/asm/topology.h |   3 -
 arch/arm64/kernel/topology.c      | 411 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 401 insertions(+), 18 deletions(-)

-- 
1.9.2
