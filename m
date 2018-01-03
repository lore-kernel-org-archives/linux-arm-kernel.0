From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:41:02 +0100
Subject: [PATCH v3 0/3] arm64: dts: r8a779[56]: Add OPPs table for cpu devices
Message-ID: <20180103124105.1999-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are dependencies for supporting CPUFreq. The remainder of that
work is being posted separately and can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq-v4


Patch 1: Cleanup of DTS, only related as its an apply-time conflict
Patches 2 & 3: Add OPPs

Changes since v2:
* Preserve alphabetical order of sub-nodes of root node
* Do not provide unit name for opps, they have no base address
* Describe clock dependency for all CPU cores

Changes since v1:
* Only provide one operating points node for each operating-points-v2 node
  as per the binding; other nodes were unused and have been removed

A description of steps taken to lightly exercise the same feature for the
r8a7795 the above can be found at the link below. The results are the same
for the r8a7796 with the exception that it has two active CPU cores rather
than four.

http://elinux.org/Tests:R-CAR-GEN3-CPUFreq


Dien Pham (2):
  arm64: dts: renesas: r8a7795: Add OPPs table for cpu devices
  arm64: dts: renesas: r8a7796: Add OPPs table for cpu devices

Simon Horman (1):
  arm64: dts: renesas: r8a7795: move scif node into alphabetical order

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 71 +++++++++++++++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 62 ++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.11.0
