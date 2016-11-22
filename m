From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 22 Nov 2016 15:49:15 +0800
Subject: [PATCH 0/6] add hisilicon reset
Message-ID: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset-hi3660.c
Update reset-hi6220 as well
reset.c is shared by reset-hi3660.c and reset-hi6220.c
Change hi6220.dtsi accordingly

Zhangfei Gao (6):
  reset: hisilicon: add reset core
  dt-bindings: Document the hi3660 reset bindings
  reset: hisilicon: add reset-hi3660
  dt-bindings: change hi6220-reset.txt according to reset-hi6220.c
  reset: hisilicon: Use new driver reset-hi6222
  arm64: dts: hi6220: update reset node according to reset-hi6220.c

 .../bindings/reset/hisilicon,hi3660-reset.txt      |  42 ++++++
 .../bindings/reset/hisilicon,hi6220-reset.txt      |  14 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  20 ++-
 drivers/reset/Makefile                             |   2 +-
 drivers/reset/hisilicon/Kconfig                    |   7 +
 drivers/reset/hisilicon/Makefile                   |   4 +-
 drivers/reset/hisilicon/hi6220_reset.c             | 157 ---------------------
 drivers/reset/hisilicon/reset-hi3660.c             |  78 ++++++++++
 drivers/reset/hisilicon/reset-hi6220.c             | 123 ++++++++++++++++
 drivers/reset/hisilicon/reset.c                    | 108 ++++++++++++++
 drivers/reset/hisilicon/reset.h                    |  37 +++++
 include/dt-bindings/reset/hisi,hi3660-resets.h     |  38 +++++
 include/dt-bindings/reset/hisi,hi6220-resets.h     | 130 ++++++++---------
 13 files changed, 527 insertions(+), 233 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 delete mode 100644 drivers/reset/hisilicon/hi6220_reset.c
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c
 create mode 100644 drivers/reset/hisilicon/reset-hi6220.c
 create mode 100644 drivers/reset/hisilicon/reset.c
 create mode 100644 drivers/reset/hisilicon/reset.h
 create mode 100644 include/dt-bindings/reset/hisi,hi3660-resets.h

-- 
2.7.4
