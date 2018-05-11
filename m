From: samuel@sholland.org (Samuel Holland)
Date: Thu, 10 May 2018 21:27:49 -0500
Subject: [PATCH 0/2] Allwinner A64 timer workaround
Message-ID: <20180511022751.9096-1-samuel@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Several people (including me) have experienced extremely large system
clock jumps on their A64-based devices, apparently due to the
architectural timer going backward, which is interpreted by Linux as
the timer wrapping around after 2^56 cycles.

Investigation led to discovery of some obvious problems with this SoC's
architectural timer, and this patch series introduces what I believe is
the simplest workaround. More details are in the commit message for
patch 1. Patch 2 simply enables the workaround in the device tree.

Thanks,
Samuel

Samuel Holland (2):
  arm64: arch_timer: Workaround for Allwinner A64 timer instability
  arm64: dts: allwinner: a64: Enable A64 timer workaround

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
 drivers/clocksource/Kconfig                   | 11 ++++++++
 drivers/clocksource/arm_arch_timer.c          | 39 +++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

--
2.16.1
