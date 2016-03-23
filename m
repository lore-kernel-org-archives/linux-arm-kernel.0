From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Mar 2016 10:06:41 +0900
Subject: [PATCH v2 0/2] ARM: dts: Remove unnecessary clock-output-names
 properties
Message-ID: <1458695203-9950-1-git-send-email-horms+renesas@verge.net.au>
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
from that of the clock node.  Accordingly, remove the unnecessary
clock-output-names properties and as necessary update the node names.

The clock-output-names property is left in place for the zb_clk which is
thus treated as a special case as the MSTP clock driver (clk-mstp.c)
explicitly looks for a clock named zb_clk for the r8a73a4 and sh73a0 SoCs.


Changes since v1:
* Omit patches which have been queued-up.
* Do not update zb_clk

Based on renesas-devel-20160318-v4.5


Simon Horman (2):
  ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
  ARM: dts: sh73a0: Remove unnecessary clock-output-names properties

 arch/arm/boot/dts/r8a73a4.dtsi | 75 ++++++++++++------------------------
 arch/arm/boot/dts/sh73a0.dtsi  | 87 ++++++++++++++----------------------------
 2 files changed, 54 insertions(+), 108 deletions(-)

-- 
2.1.4
