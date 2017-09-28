From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 28 Sep 2017 16:18:23 +0800
Subject: [PATCH v3 0/5] media: atmel-isc: Rework the format list and clock
 provider
Message-ID: <20170928081828.20335-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the readability of code, rework the format list table,
split the format array into two. Meanwhile, fix the issue of the
clock provider operation.

Changes in v3:
 - Fix the wrong used spinlock.
 - s/_/- on the subject.
 - Add a new flag for Raw Bayer format to remove MAX_RAW_FMT_INDEX define.
 - Add the comments for define of the format flag.
 - Rebase media_tree/master.

Changes in v2:
 - Add the new patch to remove the unnecessary member from
   isc_subdev_entity struct.
 - Rebase on the patch set,
        [PATCH 0/6] [media] Atmel: Adjustments for seven function implementations
        https://www.mail-archive.com/linux-media at vger.kernel.org/msg118342.html

Wenyou Yang (5):
  media: atmel-isc: Add spin lock for clock enable ops
  media: atmel-isc: Add prepare and unprepare ops
  media: atmel-isc: Enable the clocks during probe
  media: atmel-isc: Remove unnecessary member
  media: atmel-isc: Rework the format list

 drivers/media/platform/atmel/atmel-isc-regs.h |   1 +
 drivers/media/platform/atmel/atmel-isc.c      | 616 ++++++++++++++++++++------
 2 files changed, 483 insertions(+), 134 deletions(-)

-- 
2.13.0
