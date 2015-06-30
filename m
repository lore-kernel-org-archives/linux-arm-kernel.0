From: rric@kernel.org (Robert Richter)
Date: Tue, 30 Jun 2015 16:13:59 +0200
Subject: [PATCH 0/4] irqchip, gicv3: Implement Cavium ThunderX errata
Message-ID: <1435673643-31676-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch series implements workarounds for HW errata in Cavium's
ThunderX GICV3.

The first one is a gicv3 code update I sent a while ago and is a
prerequisit for patch #4. Patch #2 adds generic code to parse the hw
revision provided by an IIDR register value and runs specific code if
hw matches. This is used to implement the actual errata fixes in patch
#3 (gicv3) and #4 (gicv3-its).

Robert Richter (4):
  irqchip, gicv3-its: Read typer register outside the loop
  irqchip, gicv3: Add HW revision detection and configuration
  irqchip, gicv3: Implement Cavium ThunderX erratum 23154
  irqchip, gicv3-its: Implement Cavium ThunderX errata 22375, 24313

 drivers/irqchip/irq-gic-common.c | 11 +++++++++
 drivers/irqchip/irq-gic-common.h |  9 +++++++
 drivers/irqchip/irq-gic-v3-its.c | 51 ++++++++++++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c     | 51 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 116 insertions(+), 6 deletions(-)

-- 
2.1.1
