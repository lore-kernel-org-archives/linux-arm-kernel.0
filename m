From: jinkun.hong@rock-chips.com (jinkun.hong)
Date: Mon, 20 Oct 2014 02:03:40 -0700
Subject: [PATCH v4 0/3] ARM: rk3288 : Add PM Domain support
Message-ID: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "jinkun.hong" <jinkun.hong@rock-chips.com>

Add power domain drivers based on generic power domain for Rockchip platform,
and support RK3288.

Based on:
- [PATCH v1 1/4] PM / clock_ops: Add pm_clk_add_clk()
  http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg735599.html

Changes in v4:
- use list storage dev

Changes in v3:
- change use pm_clk_resume() and pm_clk_suspend()
- DT structure has changed
- Decomposition power-controller, changed to multiple controller
   (gpu-power-controller, hevc-power-controller)

Changes in v2:
- remove the "pd->pd.of_node = np"
- move clocks to "optional"
- make pd_vio clocks all one entry per line and alphabetize.
- power: power-controller move back to pinctrl: pinctrl.

jinkun.hong (3):
  power-domain: add power domain drivers for Rockchip platform
  dt-bindings: add document of Rockchip power domain
  ARM: dts: add rk3288 power-domain node

 .../bindings/arm/rockchip/power_domain.txt         |   46 +++
 arch/arm/boot/dts/rk3288.dtsi                      |   24 ++
 arch/arm/mach-rockchip/Kconfig                     |    1 +
 arch/arm/mach-rockchip/Makefile                    |    1 +
 arch/arm/mach-rockchip/pm_domains.c                |  360 ++++++++++++++++++++
 5 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/power_domain.txt
 create mode 100644 arch/arm/mach-rockchip/pm_domains.c

-- 
1.7.9.5
