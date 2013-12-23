From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Dec 2013 16:37:07 +0800
Subject: [PATCH 0/4] clk: sunxi: add A20 external output clock support
In-Reply-To: <1387787827-11341-1-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
Message-ID: <1387787827-11341-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch series adds support for the Allwinner A20's 2 external clock
outputs. The CubieTruck uses one such output to supply a stable 32.768
KHz low power clock to its AP6210 WiFi module. Support for the module
is being added to brcmfmac (brcm80211) by Broadcom people.

The patches should be applied after Emilio's sunxi clock series, as it
reuses the new "module 0" type clock support.

Comments?


Cheers,
ChenYu


Chen-Yu Tsai (4):
  clk: sunxi: Allwinner A20 output clock support
  ARM: dts: sun7i: external clock outputs
  pinctrl: sunxi: Add Allwinner A20 clock output pin functions
  ARM: dts: sun7i: Add pin muxing options for clock outputs

 arch/arm/boot/dts/sun7i-a20.dtsi     | 39 ++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c        | 15 ++++++++++++++
 drivers/pinctrl/pinctrl-sunxi-pins.h |  2 ++
 3 files changed, 56 insertions(+)

-- 
1.8.5.2
