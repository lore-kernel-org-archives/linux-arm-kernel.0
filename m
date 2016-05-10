From: plaes@plaes.org (Priit Laes)
Date: Tue, 10 May 2016 22:24:05 +0300
Subject: [PATCH 0/2] ARM: dts: sunxi: Add display clocks to sun[47]i.dtsi
Message-ID: <1462908247-10474-1-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the display and TCON clocks that are needed to drive the display
engine, tcon and TV encoders.

Please note that currently the parent handling for clocks using 
'allwinner,sun4i-a10-display-clk' compatible with number of parents !=4
is broken (like de_[bf]e[01]_clk clocks present in patches).

Priit Laes (2):
  ARM: sun4i: A10: Add display and TCON clocks
  ARM: sun7i: A20: Add display and TCON clocks

 arch/arm/boot/dts/sun4i-a10.dtsi | 91 ++++++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/sun7i-a20.dtsi | 85 ++++++++++++++++++++++++++++++++++---
 2 files changed, 164 insertions(+), 12 deletions(-)

-- 
2.8.2
