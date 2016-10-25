From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 25 Oct 2016 14:30:59 -0700
Subject: [PATCH 0/2] arm64, numa: Fix OOPS with numa=off
Message-ID: <1477431061-7258-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

We get an OOPS in the arm64 kernel on NUMA systems when numa=off is
passed on the command line.

Fix it by returning NUMA_NO_NODE from of_node_to_nid when numa=off.

David Daney (2):
  of, numa: Add function to disable of_node_to_nid().
  arm64, numa: Force of_node_to_nid to return NUMA_NO_NODE when
    numa=off.

 arch/arm64/mm/numa.c |  5 ++++-
 drivers/of/of_numa.c | 15 +++++++++++++++
 include/linux/of.h   |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
1.8.3.1
