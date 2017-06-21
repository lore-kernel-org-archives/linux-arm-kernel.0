From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jun 2017 10:16:39 +0530
Subject: [PATCH V2 0/5] arch_topology: Minor cleanups
Message-ID: <cover.1498019799.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

You weren't included in the first [1] version of this series, as it was
targeting arch/arm*/ directories then.

Here are some cleanups for the arch_topology core.

Tested on ARM64 Hikey board by setting following in cpu nodes in DT:
	capacity-dmips-mhz = <1000>;

V1->V2:
- based over linux-next/master (to get Juri's recent changes)
- More cleanups included. V1 only had the first patch.
- Rename of cap_parsing_failed isn't required anymore (as it is
  localized to a single routine now).

--
viresh

[1] https://marc.info/?l=linux-arm-kernel&m=149795553024005

Viresh Kumar (5):
  arch_topology: Get rid of "cap_parsing_done"
  arch_topology: Don't break lines unnecessarily
  arch_topology: Covert switch block to if block
  arch_topology: Return 0 or -ve errors from
    topology_parse_cpu_capacity()
  arch_topology: Localize cap_parsing_failed to
    topology_parse_cpu_capacity()

 arch/arm/kernel/topology.c   |  2 +-
 drivers/base/arch_topology.c | 78 ++++++++++++++++++++++----------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
