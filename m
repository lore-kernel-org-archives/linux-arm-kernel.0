From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Apr 2017 12:05:29 +0200
Subject: [PATCH 0/9] ARM: dts: renesas: update PFC node name to pin-controller
Message-ID: <20170426100538.22060-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The device trees for Renesas SoCs use either pfc or pin-controller as the
node name for the PFC device. This patch is intended to take a step towards
unifying the node name used as pin-controller which appears to be the more
generic of the two and thus more in keeping with the DT specs.

My analysis is that this is a user-visible change to the extent that kernel
logs, and sysfs entries change from XXX.pfc and pfc at XXX to
XXX.pin-controller and pin-controller at XXX.

Boot tested on:
 r8a73a4/ape6evm
 r8a7740/armadillo800evb
 r8a7778/bockw
 r8a7790/lager
 r8a7791/koelsch
 r8a7791/porter
 r8a7793/gose
 sh73a9/kzm9g

Not tested on (due to lack of hw access):
 evm2/kzm9d
 r8a7789/marzen

Simon Horman (9):
  ARM: dts: emev2: update PFC node name to pin-controller
  ARM: dts: r8a73a4: update PFC node name to pin-controller
  ARM: dts: r8a7740: update PFC node name to pin-controller
  ARM: dts: r8a7778: update PFC node name to pin-controller
  ARM: dts: r8a7779: update PFC node name to pin-controller
  ARM: dts: r8a7790: update PFC node name to pin-controller
  ARM: dts: r8a7791: update PFC node name to pin-controller
  ARM: dts: r8a7793: update PFC node name to pin-controller
  ARM: dts: sh73a0: update PFC node name to pin-controller

 arch/arm/boot/dts/emev2.dtsi   | 2 +-
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 arch/arm/boot/dts/sh73a0.dtsi  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.12.2.816.g2cccc81164
