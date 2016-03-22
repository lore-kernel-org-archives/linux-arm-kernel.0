From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:27 +0900
Subject: [PATCH 00/13] ARM,
 arm64: dts: Remove unnecessary clock-output-names properties
Message-ID: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series updates the device trees of Renesas ARM based SoCs.

* Fixed rate and fixed factor clocks do not require an
  clock-output-names property.
* Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
  optional") Renesas div6 clocks do not require a clock-output-names
  property.

In the above cases there is only one clock output and its name is taken
from that of the clock node.

Accordingly, remove the unnecessary clock-output-names properties and as
necessary update the node names. The zb_clk is excluded from this rename
as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
named zb_clk for the r8a73a4 and sh73a0 SoCs.

Based on renesas-devel-20160318-v4.5

Simon Horman (13):
  ARM: dts: r7s72100: Remove unnecessary clock-output-names properties
  ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
  ARM: dts: sh73a0: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7740: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7778: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7779: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7791: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7793: Remove unnecessary clock-output-names properties
  ARM: dts: r8a7794: Remove unnecessary clock-output-names properties
  ARM: dts: gose: Remove unnecessary clock-output-names properties
  ARM: dts: koelsch: Remove unnecessary clock-output-names properties
  ARM: dts: porter: Remove unnecessary clock-output-names properties
  ARM: dts: lager: Remove unnecessary clock-output-names properties

 arch/arm/boot/dts/r7s72100.dtsi       | 15 ++----
 arch/arm/boot/dts/r8a73a4.dtsi        | 76 ++++++++++--------------------
 arch/arm/boot/dts/r8a7740.dtsi        | 57 ++++++++---------------
 arch/arm/boot/dts/r8a7778.dtsi        | 21 +++------
 arch/arm/boot/dts/r8a7779.dtsi        | 15 ++----
 arch/arm/boot/dts/r8a7790-lager.dts   |  3 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts |  3 +-
 arch/arm/boot/dts/r8a7791-porter.dts  |  3 +-
 arch/arm/boot/dts/r8a7791.dtsi        | 79 ++++++++++---------------------
 arch/arm/boot/dts/r8a7793-gose.dts    |  3 +-
 arch/arm/boot/dts/r8a7793.dtsi        | 45 ++++++------------
 arch/arm/boot/dts/r8a7794.dtsi        | 66 +++++++++-----------------
 arch/arm/boot/dts/sh73a0.dtsi         | 88 ++++++++++++-----------------------
 13 files changed, 154 insertions(+), 320 deletions(-)

-- 
2.1.4
