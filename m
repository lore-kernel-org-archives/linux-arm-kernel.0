From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 16:44:18 +0200
Subject: [PATCH 0/4] Add support for the Allwinner A31 clocks
Message-ID: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

The Allwinner A31 SoC has a quite different clock tree and structure that the
other Allwinner SoCs that we already merged, so it requires more work than what
we had for the other SoCs until now.

It's also an opportunity to do some minor cleanup/refactoring to land the new
code properly.

This patch set is based on the "ARM: sunxi: Add support for the Allwinner A31
SoC" serie I sent previously.

Thanks!
Maxime

Maxime Ripard (4):
  clk: sunxi: Rename the structure to prepare the addition of sun6i
  clk: sunxi: Allow to specify the divider width from the dividers data
  clk: sunxi: Add A31 clocks support
  ARM: sun6i: Enable clock support in the DTSI

 arch/arm/boot/dts/sun6i-a31.dtsi | 137 +++++++++++++++++++--
 drivers/clk/sunxi/clk-sunxi.c    | 252 ++++++++++++++++++++++++++++++++-------
 2 files changed, 335 insertions(+), 54 deletions(-)

-- 
1.8.3.4
