From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2018 17:05:41 -0700
Subject: [PATCH 0/4] Update am437x and am335x dts to probe with ti-sysc
Message-ID: <20180925000545.22931-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are four patches to make am437x and am335x l4 devices to probe with
ti-sysc driver similar to what we've already done for omap4. The related
legacy hwmod platform data will be removed few merge cycles later.

There are still dependencies to Tero's clkctrl changes and for ti-sysc
drivers changes. So these patches are based on on v4.19-rc3 merged with
my omap-for-v4.20/dt branch plus the following additional series of
patches:

[PATCH 00/11] clk: ti: clkctrl data split based on clkdm boundaries
[PATCH 0/3] ARM: dts: am3/am4/dra7 clkctrl data conversion
[PATCH 0/4] TI sysc driver updates for am335x and am437x

v4.19-rc3 is needed for commit 18eb8aea7fb2 ("net: ethernet:
cpsw-phy-sel: prefer phandle for phy sel") and omap-for-v4.20/dt
is needed to avoid conflicts with clean-up.

I've also pushed out a temporary testing branch for people to test
as omap-for-v4.20/dt-ti-sysc-tmp-testing [0][1].

Regards,

Tony

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v4.20/dt-ti-sysc-tmp-testing
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.20/dt-ti-sysc-tmp-testing


Tony Lindgren (4):
  ARM: dts: am437x: Add l4 interconnect hierarchy and ti-sysc data
  ARM: dts: am437x: Move l4 child devices to probe them with ti-sysc
  ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data
  ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc

 arch/arm/boot/dts/am335x-shc.dts |    2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi | 2132 +++++++++++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi    |  623 +-------
 arch/arm/boot/dts/am4372.dtsi    |  876 +----------
 arch/arm/boot/dts/am437x-l4.dtsi | 2499 ++++++++++++++++++++++++++++++
 5 files changed, 4651 insertions(+), 1481 deletions(-)
 create mode 100644 arch/arm/boot/dts/am33xx-l4.dtsi
 create mode 100644 arch/arm/boot/dts/am437x-l4.dtsi

-- 
2.19.0
