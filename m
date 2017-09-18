From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 18 Sep 2017 14:45:11 +0800
Subject: [PATCH v4 0/3] media: ov7670: Add entity init and power operation
Message-ID: <20170918064514.6841-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to add the media entity pads initialization,
the s_power operation and get_fmt callback support.

Changes in v4:
 - Fix the build error when not enabling Media Controller API option.
 - Fix the build error when not enabling V4L2 sub-device userspace API option.

Changes in v3:
 - Keep tried format info in the try_fmt member of
   v4l2_subdev__pad_config struct.
 - Add the internal_ops callback to set default format.

Changes in v2:
 - Add the patch to support the get_fmt ops.
 - Remove the redundant invoking ov7670_init_gpio().

Wenyou Yang (3):
  media: ov7670: Add entity pads initialization
  media: ov7670: Add the get_fmt callback
  media: ov7670: Add the s_power operation

 drivers/media/i2c/ov7670.c | 128 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 7 deletions(-)

-- 
2.13.0
