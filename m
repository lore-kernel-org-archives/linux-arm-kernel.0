From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 Jul 2015 16:44:42 -0700
Subject: [PATCH 0/3] Move clk-sp810 to assigned clock parents
In-Reply-To: <55BBB2FC.9030102@codeaurora.org>
References: <55BBB2FC.9030102@codeaurora.org>
Message-ID: <1438386285-5070-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set converts this code to use the assigned-clock-parents
property instead of doing some interesting stuff in the .prepare
op. I can route the dts patches through arm-soc but I'd like to take
the clk patch through clk tree because it removes some usage of the
struct clk based provider APIs that we're trying to get rid of. Also,
this is completely untested, so testing would be appreciated.
Can this be tested with qemu? I haven't tried but I was thinking
that might be an option.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>

Stephen Boyd (3):
  clk: versatile: Switch to assigned clock parents
  ARM: dts: vexpress: Use assigned-clock-parents for sp810
  ARM64: dts: vexpress: Use assigned-clock-parents for sp810

 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi          |  2 +
 arch/arm/boot/dts/vexpress-v2m.dtsi              |  2 +
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi    |  2 +
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |  2 +
 drivers/clk/versatile/clk-sp810.c                | 76 +++++-------------------
 5 files changed, 23 insertions(+), 61 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
