From: mturquette@linaro.org (Mike Turquette)
Date: Mon,  8 Sep 2014 23:07:46 -0700
Subject: [PATCH 0/2] fixes for struct clk_core migration
Message-ID: <1410242868-14750-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few build issues have popped up with more extensive testing of the
patches to split the clock framework into a proper provider/consumer
relationship. [0]

The first patch adapts Intel's LPSS driver to use the clock provider
APIs. If no one objects to this patch then I will fold it into Tomeu's
patch #2. [1]

Tomeu, can you run your Coccinelle script again against all of arch/ and
drivers/ to make sure nothing else was left out?

The second patch brings the asm-generic version of clkdev.h up to speed
with all of the asm-specific versions, by not declaring __clk_get and
__clk_put if CONFIG_COMMON_CLK is set. If no one objects to this patch
then I will move it to the front of the patch stack when rebasing
Tomeu's series.

[0] http://lkml.kernel.org/r/<1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>
[1] http://lkml.kernel.org/r/<1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>

Mike Turquette (2):
  acpi: lpss: convert from struct clk to struct clk_core
  asm-generic: COMMON_CLK defines __clk_{get,put}

 drivers/acpi/acpi_lpss.c               | 6 +++---
 include/asm-generic/clkdev.h           | 2 ++
 include/linux/platform_data/clk-lpss.h | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.8.3.2
