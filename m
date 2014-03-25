From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Mar 2014 19:56:24 +0100
Subject: [PATCH v2 0/5] ARM: shmobile: r8a7790: enable IIC(B) cores
Message-ID: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allows r8a7790 boards to use the alternative IIC(B) controller
handled by the i2c-sh_mobile driver. Since both i2c cores always use the same
pins only in a different function group, you can easily use this or that core
for your devices. For that reason, there is currently no enablement on the
Lager board, since it needs discussion which core we want to have on which bus.
sh_mobile seems more stable currently, so I'd vote for that. However, this can
be applied incrementally later.

This series is still based on renesas-devel-v3.14-rc5-20140307v2 and has been
tested on a Lager board. The main intention of this version is to gather
further comments or ACKs. Once all is good, I will then rebase the series onto
latest renesas-devel around next rc1 time as discussed with Magnus.

Branch is here: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r8a7790-iic

All comments from Laurent have been addressed since V1. Please review.

Thanks,

   Wolfram


Wolfram Sang (5):
  pinctrl: pfc: r8a7790: add i2c0 muxing
  pinctrl: pfc: r8a7790: add mux data for IIC(B) cores
  ARM: shmobile: r8a7790: add IIC0-2 clock macros
  ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
  ARM: shmobile: r8a7790: add IIC(B) cores to dtsi

 arch/arm/boot/dts/r8a7790.dtsi            |  71 ++++++++++++---
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c      | 138 +++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7790-clock.h |   3 +
 3 files changed, 197 insertions(+), 15 deletions(-)

-- 
1.9.0
