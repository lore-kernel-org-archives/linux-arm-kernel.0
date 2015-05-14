From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 14 May 2015 17:03:30 +0530
Subject: [PATCH v2 0/5] Add flexcan support for LS1021A SoCs
Message-ID: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add the support for FlexCAN module present
on LS1021A SoCs.

LS1021A-Rev1 SoC has a broken RX FIFO mode, thereby mandating
the use of message buffers for frame reception.

LS1021A-Rev2 SoC has this issue fixed.

Bhupesh Sharma (3):
  doc/bindings: Add 'endianess' optional-property for FlexCAN
    controller
  can: flexcan: Add ls1021a flexcan device entry
  can: flexcan: Add support for non RX-FIFO mode

Sakar Arora (2):
  arm/dts: Add nodes for flexcan devices present on LS1021A SoC
  can: flexcan: Remodel FlexCAN register r/w APIs for BE instances

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 +
 arch/arm/boot/dts/ls1021a-qds.dts                  |    8 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   18 +
 drivers/net/can/flexcan.c                          |  400 +++++++++++++-------
 4 files changed, 299 insertions(+), 131 deletions(-)

-- 
1.7.9.5
