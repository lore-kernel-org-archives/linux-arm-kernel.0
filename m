From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 26 Jul 2017 11:06:38 +0530
Subject: [PATCH 0/6] Broadcom SBA-RAID driver improvements
Message-ID: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does various improvments to Broadcom SBA-RAID
driver and also adds SBA-RAID DT nodes for Stingray SOC.

The patches are based on "[PATCH v2 0/7] FlexRM driver improvements"
and can also be found at sba-raid-imp-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Anup Patel (6):
  dma: bcm-sba-raid: Improve memory allocation in SBA RAID driver
  dma: bcm-sba-raid: Peek mbox when we are left with no free requests
  dma: bcm-sba-raid: pre-ack async tx descriptor
  dma: bcm-sba-raid: Break sba_process_deferred_requests() into two
    parts
  dma: bcm-sba-raid: Add debugfs support
  arm64: dts: Add SBA-RAID DT nodes for Stingray SoC

 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  64 +++
 drivers/dma/bcm-sba-raid.c                         | 527 ++++++++++++---------
 2 files changed, 364 insertions(+), 227 deletions(-)

-- 
2.7.4
