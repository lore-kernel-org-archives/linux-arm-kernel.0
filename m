From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 16 Oct 2018 17:15:12 +0800
Subject: [PATCH 0/4] add support for MBIGEN generating message based SPIs
Message-ID: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
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

Yang Yingliang (4):
  irqchip/gic-v3-mbi: fix uninitialized mbi_lock
  irqchip/mbigen: rename register marcros
  irqchip/mbigen: add support for a MBIGEN generating SPIs
  dt-bindings/irqchip/mbigen: add example of MBIGEN generate SPIs

 .../interrupt-controller/hisilicon,mbigen-v2.txt   | 17 +++++++++-
 drivers/irqchip/irq-gic-v3-mbi.c                   |  2 +-
 drivers/irqchip/irq-mbigen.c                       | 39 ++++++++++++++++------
 3 files changed, 45 insertions(+), 13 deletions(-)

-- 
1.8.3
