From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  4 Jun 2018 11:39:52 +0100
Subject: [PATCH 0/5] arm64: numa/topology/smp: fix the cpumasks for CPU hotplug
Message-ID: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin, Jeremy, Morten,

This is the fix I could come up for the issues we are seeing with arm64
for-next branch, in particular with commit 37c3ec2d810f ("arm64: topology:
divorce MC scheduling domain from core_siblings").

The solution is to update the CPU topology during CPU hotplug operations
similar to other architectures like x86 and PPC. This is also inline
with the expection from the scheduler.

I have cc-ed few Cavium and Huawei guys as they seem to have added or
modified the numa related code in the past.

Regards,
Sudeep

Sudeep Holla (5):
  arm64: topology: refactor reset_cpu_topology to add support for removing topology
  arm64: topology: add support to remove cpu topology
  arm64: numa: separate out updates to percpu nodeid and NUMA node cpumap
  arm64: smp: remove cpu and numa topology information when hotplugging out CPU
  arm64: topology: rename llc_siblings to align with other struct members

 arch/arm64/include/asm/numa.h     |  4 +++
 arch/arm64/include/asm/topology.h |  3 ++-
 arch/arm64/kernel/smp.c           |  5 ++++
 arch/arm64/kernel/topology.c      | 54 +++++++++++++++++++++++++++------------
 arch/arm64/mm/numa.c              | 29 +++++++++++++++------
 5 files changed, 70 insertions(+), 25 deletions(-)

--
2.7.4
