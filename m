From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2018 15:44:41 -0700
Subject: [PATCH 0/4] TI sysc driver updates for am335x and am437x
Message-ID: <20180924224445.97239-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few updates for ti-sysc driver for am335x and am437x. I'll be
posting the related dts changes separately.

Based on testing with various devices, we can now also get rid of the
quirk flag for SYSC_QUIRK_RESOURCE_PROVIDER and make module names limited
to debug only except for few devices still using pm_runtime_irq_safe().

Regards,

Tony

Tony Lindgren (4):
  bus: ti-sysc: Defer suspend as needed
  bus: ti-sysc: Update revision masks to support am437x
  bus: ti-sysc: Detect more devices on am473x for debugging
  bus: ti-sysc: Detect devices on am335x when DEBUG is enabled

 drivers/bus/ti-sysc.c                 | 143 +++++++++++++++-----------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 85 insertions(+), 59 deletions(-)

-- 
2.19.0
