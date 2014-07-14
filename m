From: sassmann@kpanic.de (Stefan Assmann)
Date: Mon, 14 Jul 2014 13:50:53 +0200
Subject: [PATCH RFC 0/2] Enable wifi on pandaboard
Message-ID: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the pandaboard the wifi isn't recognized because clk32kg was never enabled.
The code to handle the clock got removed successively because it was not used.
For now I've reverted the respective commits although I'm not sure if this is
acceptable. If it needs to be converted to the clock API some pointers in the
right direction would be appreciated, as I'm not familiar with it.
Thanks!

Stefan Assmann (2):
  dts: regulator-clk32kg should always be enabled
  regulator: twl: Re-add clk32kg to get wifi working

 .../bindings/regulator/twl-regulator.txt           |  1 +
 arch/arm/boot/dts/twl6030.dtsi                     |  1 +
 drivers/regulator/twl-regulator.c                  | 23 ++++++++++++++++++++++
 3 files changed, 25 insertions(+)

-- 
1.9.3
