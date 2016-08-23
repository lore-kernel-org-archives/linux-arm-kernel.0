From: hotran@apm.com (Hoan Tran)
Date: Tue, 23 Aug 2016 08:52:38 -0700
Subject: [PATCH 0/3] clk: xgene: Add PMD clock support
Message-ID: <1471967561-23634-1-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add X-Gene PMD clock support.

PMD clock is implemented for a single register field.
  Output rate = parent_rate * (denominator - scale) / denominator
with
  - denominator = bitmask of register field + 1
  - scale = value of register field

For example, for bitmask is 0x7, denominator will be 8 and scale
will be computed and programmed accordingly.

Hoan Tran (3):
  Documentation: dtb: xgene: Add PMD clock binding
  clk: xgene: Add PMD clock
  arm64: dts: xgene: Add DT node for APM X-Gene 2 CPU clocks

 Documentation/devicetree/bindings/clock/xgene.txt |  22 +++
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi        |  64 +++++++
 drivers/clk/clk-xgene.c                           | 223 ++++++++++++++++++++++
 3 files changed, 309 insertions(+)

-- 
1.9.1
