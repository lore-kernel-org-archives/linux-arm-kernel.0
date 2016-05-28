From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Sat, 28 May 2016 17:22:52 +0800
Subject: [PATCH v2 0/5] fix some type infos and bugs for arm64/of numa
Message-ID: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1 -> v2:
1. Base on https://lkml.org/lkml/2016/5/24/679
2. Rewrote of_numa_parse_memory_nodes according to Rob Herring's advice. So that it looks more clear.
3. Rewrote patch 5 because some scenes were not considered before.

Zhen Lei (5):
  of/numa: remove a duplicated pr_debug information
  of/numa: fix a memory@ node can only contains one memory block
  arm64/numa: add nid check for memory block
  of/numa: remove a duplicated warning
  arm64/numa: avoid inconsistent information to be printed

 arch/arm64/mm/numa.c | 11 ++++++++---
 drivers/of/of_numa.c | 42 ++++++++++++------------------------------
 2 files changed, 20 insertions(+), 33 deletions(-)

-- 
2.5.0
