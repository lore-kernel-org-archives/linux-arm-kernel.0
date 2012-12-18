From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 19 Dec 2012 00:16:20 +0100
Subject: [PATCH 0/3] clk: Provide option to unprepare unused clocks at late
 init
Message-ID: <1355872583-20928-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The disable_unused sequence executed at late init, is already handling the
fast unused ungated clocks to be gated. This patchset extends this sequence to
include the slow unused prepared clocks to be unprepared.

The default behavior will not change in this patchset. To unprepare unused
clocks during the disable_unused sequence, the clk_hw needs to implement
the new optional callback, is_prepared.

The motivation for this patchset is to save power. Clocks that is from
bootloaders prepared|enabled, but not used should be unprepared|disabled.

Ulf Hansson (3):
  clk: Introduce optional is_prepared callback
  clk: Unprepare the unused prepared slow clocks at late init
  clk: Introduce optional unprepare_unused callback

 drivers/clk/clk.c            |   53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   11 +++++++++
 2 files changed, 64 insertions(+)

-- 
1.7.10
