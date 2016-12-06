From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue,  6 Dec 2016 09:51:30 +0800
Subject: [PATCH v3 0/2] add reset-hi3660
Message-ID: <1480989092-31847-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:
change dts usage suggested by Arnd
from
resets = <&iomcu_rst 0>;
to
resets = <&iomcu_rst 0x20 3>; /* offset: 0x20; bit: 3 */

v2:
Considering Arnd and Philipp suggestions, 
move reset register to dts as table instead of dts header in case of ABI issue

Zhangfei Gao (2):
  dt-bindings: Document the hi3660 reset bindings
  reset: hisilicon: add reset-hi3660

 .../bindings/reset/hisilicon,hi3660-reset.txt      |  36 ++++++
 drivers/reset/hisilicon/Kconfig                    |   7 ++
 drivers/reset/hisilicon/Makefile                   |   1 +
 drivers/reset/hisilicon/reset-hi3660.c             | 126 +++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
 create mode 100644 drivers/reset/hisilicon/reset-hi3660.c

-- 
2.7.4
