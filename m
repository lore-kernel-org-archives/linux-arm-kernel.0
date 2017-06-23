From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jun 2017 14:55:29 +0530
Subject: [PATCH V3 0/5] arch_topology: Minor cleanups
Message-ID: <cover.1498209817.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

You weren't included in the first [1] version of this series, as it was
targeting arch/arm*/ directories then.

Here are some cleanups for the arch_topology core.

Tested on ARM64 Hikey board by setting following in cpu nodes in DT:
        capacity-dmips-mhz = <1000>;

V2->V3:
- topology_parse_cpu_capacity() returns bool now (Juri).
- "Get rid of cap_parsing_done" is the last patch now and its
  implementation is change a bit (Juri).

V1->V2:
- based over linux-next/master (to get Juri's recent changes)
- More cleanups included. V1 only had the first patch.
- Rename of cap_parsing_failed isn't required anymore (as it is
  localized to a single routine now).

--
viresh

[1] https://marc.info/?l=linux-arm-kernel&m=149795553024005

Viresh Kumar (5):
  arch_topology: Don't break lines unnecessarily
  arch_topology: Convert switch block to if block
  arch_topology: Change return type of topology_parse_cpu_capacity() to
    bool
  arch_topology: Localize cap_parsing_failed to
    topology_parse_cpu_capacity()
  arch_topology: Get rid of cap_parsing_done

 drivers/base/arch_topology.c  | 78 +++++++++++++++++++++----------------------
 include/linux/arch_topology.h |  4 ++-
 2 files changed, 42 insertions(+), 40 deletions(-)

-- 
2.13.0.71.gd7076ec9c9cb
