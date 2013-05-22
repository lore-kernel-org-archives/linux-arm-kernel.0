From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 May 2013 13:40:15 -0700
Subject: [RFC/PATCH 0/2] Remove most of_device_match() calls
Message-ID: <1369255217-29764-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sending this as an RFC with one driver converted to see what people
think. The goal is to avoid having to run the match twice and be
similar to how platform_device_id works right now. If people agree
I can go through and send out patches for all the drivers doing
the duplicate search (~100 files).

Stephen Boyd (2):
  of: Assign of_device_id to matching device_node
  gpio/omap: Use of_node->id_entry directly

 drivers/gpio/gpio-omap.c  |  4 +---
 drivers/of/device.c       | 18 ++++++++++++++++++
 include/linux/of.h        |  1 +
 include/linux/of_device.h | 12 ++----------
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
