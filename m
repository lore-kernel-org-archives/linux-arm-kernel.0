From: jinkun.hong@rock-chips.com (jinkun.hong)
Date: Sun, 28 Sep 2014 03:22:51 -0700
Subject: [PATCH v2 0/3] ARM: rk3288 : Add PM Domain support
Message-ID: <1411899774-8484-1-git-send-email-jinkun.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "jinkun.hong" <jinkun.hong@rock-chips.com>

Use PM Domain framework to manage the clock.

Changes in v2:
- remove the "pd->pd.of_node = np"
Adviced by Doug
- move clocks to "optional"
Adviced by Daniel
- make pd_vio clocks all one entry per line and alphabetize.
Adviced by Heiko
- power: power-controller move back to pinctrl: pinctrl.

jinkun.hong (3):
  power-domain: add power domain drivers for Rockchip platform
  dt-bindings: add document of Rockchip power domain
  ARM: dts: add rk3288 power-domain node

 .../bindings/arm/rockchip/power_domain.txt         |   48 +++
 arch/arm/boot/dts/rk3288.dtsi                      |   67 ++++
 arch/arm/mach-rockchip/Kconfig                     |    1 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/pm_domains.c                |  371 ++++++++++++++++++++
 include/dt-bindings/power-domain/rk3288.h          |   11 +
 6 files changed, 499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
 create mode 100644 arch/arm/mach-rockchip/pm_domains.c
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

-- 
1.7.9.5
