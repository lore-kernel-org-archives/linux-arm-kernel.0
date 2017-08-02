From: chen.zhong@mediatek.com (Chen Zhong)
Date: Wed, 2 Aug 2017 11:17:16 +0800
Subject: [PATCH 0/4] Add MediaTek PMIC keys support
Message-ID: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From a14ecbf89f5f74fe257e96107b0c3c4bfa0d55dc Mon Sep 17 00:00:00 2001
From: Chen Zhong <chen.zhong@mediatek.com>
Date: Tue, 1 Aug 2017 20:31:53 +0800
Subject: [PATCH 0/4] Add MediaTek PMIC keys support 

MediaTek PMIC are multi-function devices that can handle key
interrupts, typically there are two keys attached to PMIC, which
called pwrkey and homekey. PWRKEY is usually used to wake up system
from sleep. Homekey can be used as volume down key due to board
design. Long press keys can shutdown PMIC, the mode can be chosen
to be one key only or two keys together.

This series add support for key functions for MediaTek PMIC
MT6397/MT6323.

Chen Zhong (4):
  dt-bindings: input: Add document bindings for mtk-pmic-keys
  dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
  input: Add MediaTek PMIC keys support
  mfd: mt6397: Add PMIC keys support to MT6397 driver

 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   36 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    6 +
 drivers/input/keyboard/mtk-pmic-keys.c             |  320 ++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   28 +-
 4 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

-- 
1.7.9.5
