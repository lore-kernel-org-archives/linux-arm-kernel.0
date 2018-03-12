From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 12 Mar 2018 14:49:51 +0800
Subject: [RFC PATCH 0/4] add support for CommonLPIAff field
Message-ID: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adjust struct rdists to support CommonLPIAff field.
This field is described in spec:

CommonLPIAff, bits [25:24]
The affinity level at which Redistributors share a LPI Configuration table.
00 All Redistributors must share a LPI Configuration table.
01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
10 All Redistributors
11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration
table.

Yang Yingliang (4):
  irqchip/gic-v3: add common_aff_lpi field in struct rdists
  irqchip/gic-v3-its: replace alloc_pages() with alloc_pages_node()
  irqchip/gic-v3-its: change prop_page to per-cpu type to support
    CommonLPIAff field
  irqchip/gic-v3-its: sync config of LPIs if there are more than one
    prop_page

 drivers/irqchip/irq-gic-v3-its.c   | 125 +++++++++++++++++++++++++++----------
 drivers/irqchip/irq-gic-v3.c       |  20 ++++++
 include/linux/irqchip/arm-gic-v3.h |   9 ++-
 3 files changed, 121 insertions(+), 33 deletions(-)

-- 
1.8.3
