From: kevin.wangtao@hisilicon.com (Tao Wang)
Date: Fri, 22 Sep 2017 17:42:03 +0800
Subject: [PATCH 0/9] add support for Hi3660 tsensor
Message-ID: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

This patchset reorganize hisi thermal driver and make it both
support Hi6220 and Hi3660.
This patchset is based on Daniel thermal patch V2.
https://lkml.org/lkml/2017/9/4/432

Kevin Wangtao (9):
  thermal/drivers/hisi: move clk operation to related function
  thermal/drivers/hisi: use round up step value
  thermal/drivers/hisi: put platform code together
  thermal/drivers/hisi: add platform prefix to function name
  thermal/drivers/hisi: perpare to add support for other hisi platform
  thermal/drivers/hisi: add support for multi temp threshold
  dt-bindings: Document the hi3660 thermal sensor binding
  thermal/drivers/hisi: add support for hi3660 SoC
  arm64: dts: register Hi3660's thermal sensor

 .../bindings/thermal/hisilicon-thermal.txt         |   9 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +
 drivers/thermal/hisi_thermal.c                     | 494 ++++++++++++++-------
 3 files changed, 351 insertions(+), 160 deletions(-)

-- 
2.8.1
