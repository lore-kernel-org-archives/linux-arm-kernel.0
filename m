From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 24 Aug 2012 11:17:41 +0200
Subject: [PATCH 0/5] Add device tree support for on-chip SRAM
Message-ID: <1345799866-19876-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support to configure the on-chip SRAM via device-tree
node and to obtain the resulting genalloc pool from a phandle pointing   
at the node.
This allows drivers to allocate SRAM with the genalloc API without
hard-coding the genalloc pool address.

regards
Philipp

---
 arch/arm/boot/dts/imx53.dtsi          |    5 ++
 arch/arm/boot/dts/imx6q.dtsi          |    5 ++
 arch/arm/plat-mxc/include/mach/iram.h |   41 -----------------
 arch/arm/plat-mxc/iram_alloc.c        |   81 ++++++++++++++++++++-------------
 include/linux/genalloc.h              |   14 ++++++
 lib/genalloc.c                        |   77 +++++++++++++++++++++++++++++++
 6 files changed, 150 insertions(+), 73 deletions(-)
