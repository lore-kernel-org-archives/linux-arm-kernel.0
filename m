From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 26 Oct 2018 15:51:16 +0800
Subject: [PATCH v2 0/4] add support for MBIGEN generating message based SPIs
Message-ID: <1540540280-26612-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now MBIGENs have pins that used to generate SPIs,
with
5052875 ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller"),
we can support MBIGEN to generate message based SPIs by writing
GICD_SETSPIR. This patchset add support for MBIGEN generating
message based SPIs and a bugfix for MBI driver.


Patch #1 is a bugfix for MBI driver.
Pathc #2 ~ #4 is support for MBIGEN generating message based SPIs.

v2:
Move the doorbell address comments to the top.

Yang Yingliang (4):
  irqchip/gic-v3-mbi: fix uninitialized mbi_lock
  irqchip/mbigen: rename register marcros
  irqchip/mbigen: add support for a MBIGEN generating SPIs
  dt-bindings/irqchip/mbigen: add example of MBIGEN generate SPIs

 .../interrupt-controller/hisilicon,mbigen-v2.txt   | 17 +++++++-
 drivers/irqchip/irq-gic-v3-mbi.c                   |  2 +-
 drivers/irqchip/irq-mbigen.c                       | 47 +++++++++++++++-------
 3 files changed, 50 insertions(+), 16 deletions(-)

-- 
1.8.3
