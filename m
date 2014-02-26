From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Feb 2014 09:48:34 +0900
Subject: [PATCH 0/4] arm64: Topology
Message-ID: <1393375718-32458-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the scheduler documented default for unknown CPUs rather than
assigning them to a cluster.

Mark Brown (4):
      arm64: topology: Implement basic CPU topology support
      arm64: topology: Add support for topology DT bindings
      arm64: topology: Tell the scheduler about the relative power of cores
      arm64: topology: Provide relative power numbers for cores

 arch/arm64/Kconfig                |  24 +++
 arch/arm64/include/asm/topology.h |  39 ++++
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/smp.c           |  11 ++
 arch/arm64/kernel/topology.c      | 380 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 455 insertions(+)
