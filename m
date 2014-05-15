From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:39:29 +0900
Subject: [PATCH v2 0/4] ARM: shmobile: marzen: Initialise SCIF devices using DT
Message-ID: <1400153973-25546-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to provide a working prototype for enabling
SCIF devices using DT on the marzen board when booting using multiplatform.

This series addresses the review received for v1.
Changes are noted in the changelog of each updated patch.


This series depends on:
[PATCH v6 00/17] ARM: shmobile: r8a7779, marzen: CCF and multiplatform

This series was created and tested with the above mentioned series applied
on top of a merge of:
* The renesas-devel-v3.15-rc1-20140515 tag of my renesas tree.
* The clk-next branch of Mike Turquettes's tree
  This is to provide the following which were previously part of this series:
  - clk: shmobile: r8a7779: Add MSTP clock support
  - clk: shmobile: r8a7779: Add clocks support

This series works in conjunction with but does not have a run-time or compile
time dependency on:
[PATCH v3] serial: sh-sci: Add device tree support for r8a7779


Simon Horman (4):
  ARM: shmobile: r8a7779: Add scif nodes to dtsi
  ARM: shmobile: marzen: Remove early_printk from command line
  ARM: shmobile: marzen: Initialise SCIF devices using DT
  ARM: shmobile: marzen: Do not use workaround for scif devices

 arch/arm/boot/dts/r8a7779-marzen.dts            | 24 ++++++++--
 arch/arm/boot/dts/r8a7779.dtsi                  | 60 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-marzen-reference.c |  6 ---
 arch/arm/mach-shmobile/setup-r8a7779.c          |  8 ++--
 4 files changed, 84 insertions(+), 14 deletions(-)

-- 
1.8.5.2
