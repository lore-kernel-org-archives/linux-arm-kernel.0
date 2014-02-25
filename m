From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Feb 2014 13:25:41 +0900
Subject: [PATCH 0/4] arm64: topology: CPU topology support
Message-ID: <1393302345-18253-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This revision of the series places any otherwise unmapped CPUs into a
cluster in order to avoid confusing the scheduler if no topology
information is provided.  This means that we should never bring up a CPU
with no topology information so while the warning is still present and
has been upgraded it should never triger unless there is a genuine bug
(as opposed to missing information).

Mark Brown (4):
      arm64: topology: Implement basic CPU topology support
      arm64: topology: Add support for topology DT bindings
      arm64: topology: Tell the scheduler about the relative power of cores
      arm64: topology: Provide relative power numbers for cores

 arch/arm64/Kconfig                |  24 +++
 arch/arm64/include/asm/topology.h |  39 ++++
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/smp.c           |  11 ++
 arch/arm64/kernel/topology.c      | 388 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 463 insertions(+)
