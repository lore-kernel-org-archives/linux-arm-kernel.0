From: vigneshr@ti.com (Vignesh R)
Date: Wed, 3 Jun 2015 17:21:19 +0530
Subject: [PATCH v2 0/5] Add support for PWMSS on DRA7
Message-ID: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patch series adds support for PWMSS on DRA7. The IP is same as that
present in AM33XX and AM43XX.
The first patch changes clock domain in which PWMSS is present
(l4per2_7xx_clkdm) to SW_WKUP. This is because legacy IPs like PWM
does'nt support HW_AUTO prorperly. Hence, switch clock domain to
SW_WKUP. This is based on the input from the hardware team.
The rest of the patches add hwmod and dt entries and enable PWMSS on
DRA7 based SoCs.

Vignesh R (5):
  ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP
  ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
  ARM: dts: DRA7: Add TBCLK for PWMSS
  clk: ti: DRA7: Add tbclk data for ehrpwm
  ARM: dts: DRA7: Add dt nodes for PWMSS

 .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |   8 +
 .../devicetree/bindings/pwm/pwm-tipwmss.txt        |  17 +-
 arch/arm/boot/dts/dra7.dtsi                        |  69 ++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  26 +++
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 239 +++++++++++++++++++
 drivers/clk/ti/clk-7xx.c                           |   3 +
 7 files changed, 362 insertions(+), 2 deletions(-)

-- 
2.4.1
