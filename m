From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Thu, 18 Aug 2016 16:52:17 +0800
Subject: [PATCH v2 0/4] PM / AVS: add Rockchip cpu avs
Message-ID: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Under the same frequency, the operating voltage tends to decrease with
increasing leakage. so it is necessary to adjust opp's voltage according
to leakage for power.

V1->V2:
- 2/3 just add a static inline functiong in the of.h.
- 3/3 is separated into two patches.

Finley Xiao (4):
  nvmem: rockchip-efuse: Change initcall to subsys
  of: introduce of_property_read_s32_index
  dt-bindings: add binding document for Rockchip cpu avs
  PM / AVS: rockchip-cpu-avs: add driver handling Rockchip cpu avs

 .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
 drivers/nvmem/rockchip-efuse.c                     |   9 +-
 drivers/power/avs/Kconfig                          |   9 +
 drivers/power/avs/Makefile                         |   1 +
 drivers/power/avs/rockchip-cpu-avs.c               | 331 +++++++++++++++++++++
 include/linux/of.h                                 |   8 +
 6 files changed, 394 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
 create mode 100644 drivers/power/avs/rockchip-cpu-avs.c

-- 
1.9.1
