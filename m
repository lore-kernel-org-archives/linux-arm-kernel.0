From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:25 +0100
Subject: [PATCH 0/6] amba: Drop legacy PM support and some other PM
 improvements
Message-ID: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set start by converting a few AMBA drivers to use the modern PM ops.
Once the final driver is converted we are able to remove the legacy PM support
in the AMBA bus in patch 4.

Patch 5 is a cleanup patch related to clocks. Patch 6 improves the runtime PM
support around clock handling.

Ulf Hansson (6):
  ALSA: AACI: Convert to modern PM ops
  serial: pl010: Convert to modern PM ops
  serial: pl011: Convert to modern PM ops
  amba: Drop legacy PM support and use the pm_generic functions
  amba: Convert to clk_prepare_enable and clk_disable_unprepare
  amba: Add clk_prepare|unprepare in runtime PM callbacks

 drivers/amba/bus.c              |  214 +++------------------------------------
 drivers/tty/serial/amba-pl010.c |   15 +--
 drivers/tty/serial/amba-pl011.c |   17 ++--
 sound/arm/aaci.c                |   23 ++---
 4 files changed, 43 insertions(+), 226 deletions(-)

-- 
1.7.9.5
