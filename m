From: finley.xiao@rock-chips.com (Finlye Xiao)
Date: Tue, 16 Aug 2016 10:38:56 +0800
Subject: [PATCH v1 0/3] PM / AVS: add Rockchip cpu avs
Message-ID: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Under the same frequency, the operating voltage tends to decrease with
increasing leakage. so it is necessary to adjust opp's voltage according
to leakage for power.

Finley Xiao (3):
  nvmem: rockchip-efuse: Change initcall to subsys
  of: Add support for reading a s32 from a multi-value property.
  PM / AVS: rockchip-cpu-avs: add driver handling Rockchip cpu avs

 .../devicetree/bindings/power/rockchip-cpu-avs.txt |  37 +++
 drivers/nvmem/rockchip-efuse.c                     |   9 +-
 drivers/of/base.c                                  |  23 ++
 drivers/power/avs/Kconfig                          |   8 +
 drivers/power/avs/Makefile                         |   1 +
 drivers/power/avs/rockchip-cpu-avs.c               | 314 +++++++++++++++++++++
 include/linux/of.h                                 |  10 +
 7 files changed, 401 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-cpu-avs.txt
 create mode 100644 drivers/power/avs/rockchip-cpu-avs.c

-- 
1.9.1
