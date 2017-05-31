From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 31 May 2017 08:14:51 +0200
Subject: [PATCH v2 0/6] iMX6: Implement power off over standby signal
Message-ID: <20170531061457.23744-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
 - export pm_power_off_prepare to fix pfuze100-regulator as module compilation.

Oleksij Rempel (6):
  ARM: imx6q: provide documentation for new fsl,pmic_stby_poweroff
    property
  ARM: imx6: register pm_power_off handler if "fsl,pmic_stby_poweroff"
    is set
  kernel/reboot.c: export pm_power_off_prepare
  regulator: pfuze100: add fsl,pmic_stby_poweroff property
  regulator: pfuze100-regulator: provide pm_power_off_prepare handler
  ARM: dts: imx6: RIoTboard provide Standby to PowerOff option

 .../devicetree/bindings/clock/imx6q-clock.txt      |  4 ++
 .../devicetree/bindings/regulator/pfuze100.txt     |  4 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  5 ++
 arch/arm/mach-imx/pm-imx6.c                        | 30 +++++++++
 drivers/regulator/pfuze100-regulator.c             | 76 ++++++++++++++++++++++
 kernel/reboot.c                                    |  1 +
 6 files changed, 120 insertions(+)

Cc: kernel at pengutronix.de
Cc: linux-arm-kernel at lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk at vger.kernel.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org

-- 
2.11.0
