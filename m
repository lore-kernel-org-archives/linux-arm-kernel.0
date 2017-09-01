From: leo.yan@linaro.org (Leo Yan)
Date: Fri,  1 Sep 2017 08:47:13 +0800
Subject: [PATCH 0/2] Add support for Hi6220 coresight
Message-ID: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for coresight on Hi6220; the first patch
is to fix coresight PLL so can avoid system hang after we enable
coresight, the second patch is to add DT binding according to coresight
topology.

The patch has been tested on Hikey; By using OpenCSD snapshot mode, it
can successfully decode ETF and ETB trace data.

Leo Yan (1):
  clk: hi6220: mark clock cs_atb_syspll as critical

Li Pengcheng (1):
  arm64: dts: hi6220: add coresight binding

 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 379 +++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   2 +
 drivers/clk/hisilicon/clk-hi6220.c                 |   2 +-
 3 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi

-- 
2.7.4
