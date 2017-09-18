From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 18 Sep 2017 14:39:20 +0800
Subject: [PATCH v2 0/5] media: atmel-isc: Rework the format list and the clock
Message-ID: <20170918063925.6372-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the readability of code, rework the format list table,
split the format array into two.
Meanwhile, fix the clock operation issue.

Changes in v2:
 - Add the new patch to remove the unnecessary member from
   isc_subdev_entity struct.
 - Rebase on the patch set,
        [PATCH 0/6] [media] Atmel: Adjustments for seven function implementations
        https://www.mail-archive.com/linux-media at vger.kernel.org/msg118342.html

Wenyou Yang (5):
  media: atmel_isc: Add spin lock for clock enable ops
  media: atmel-isc: Add prepare and unprepare ops
  media: atmel-isc: Enable the clocks during probe
  media: atmel-isc: Remove unnecessary member
  media: atmel-isc: Rework the format list

 drivers/media/platform/atmel/atmel-isc-regs.h |   1 +
 drivers/media/platform/atmel/atmel-isc.c      | 609 ++++++++++++++++++++------
 2 files changed, 476 insertions(+), 134 deletions(-)

-- 
2.13.0
