From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Mon,  7 Mar 2016 13:51:53 -0600
Subject: [PATCH 0/5] ARM: am335x/am437x: Correct pwm bindings
Message-ID: <1457380318-15452-1-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike the majority of other SOCs the PWM node uses ehrpwm instead of
the generic pwm node name. This patch series switches to the pwm node
name and while at it fix some other minor binding documentation issues.

This patch series also includes a patch to insure ABI compatibility.

This series was tested on AM335x and AM437x GP evm. I also validated that
ABI compatibility was maintained.

Franklin S Cooper Jr (5):
  clk: ti: am335x/am4372: Add tbclk to pwm node
  ARM: DTS: da850/am4372/am33xx: Use generic node name for ehrpwm
  ARM: DTS: am33xx: Set pwmss ranges property to an empty value
  pwm: pwm-tipwmss: Update documentation to use empty range property
  pwm: pwm-tiehrpwm: Update dt binding document to use generic node name

 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt |  4 ++--
 Documentation/devicetree/bindings/pwm/pwm-tipwmss.txt  | 12 ++++--------
 arch/arm/boot/dts/am33xx.dtsi                          | 18 ++++++------------
 arch/arm/boot/dts/am4372.dtsi                          | 12 ++++++------
 arch/arm/boot/dts/da850.dtsi                           |  4 ++--
 drivers/clk/ti/clk-33xx.c                              |  3 +++
 drivers/clk/ti/clk-43xx.c                              |  6 ++++++
 7 files changed, 29 insertions(+), 30 deletions(-)

-- 
2.7.0
