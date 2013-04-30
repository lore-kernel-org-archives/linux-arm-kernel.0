From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Apr 2013 11:56:21 +0200
Subject: [PATCH 0/2] ARM: sunxi: Clock fixes for the Allwinner A13
Message-ID: <1367315783-21345-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a patchset making the current clock code fit for the A13.
The A13 has less clock gates available, while the logic remains, so
we need to make very few changes to handle the A13.

Thanks,
Maxime 

Maxime Ripard (2):
  clk: sun5i: Add compatibles for Allwinner A13
  ARM: sun5i: Update the clock compatible strings

 Documentation/devicetree/bindings/clock/sunxi.txt  | 117 +++------------------
 .../bindings/clock/sunxi/sun4i-a10-gates.txt       |  93 ++++++++++++++++
 .../bindings/clock/sunxi/sun5i-a13-gates.txt       |  58 ++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  35 +++---
 drivers/clk/sunxi/clk-sunxi.c                      |  31 ++++--
 5 files changed, 199 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt

-- 
1.8.1.2
