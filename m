From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 17 Dec 2014 22:15:38 +0100
Subject: [PATCHv10 0/2] Add Allwinner SoCs PWM support
Message-ID: <1418850940-30835-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the PWM controller found on the Allwinner
SoCs.

The first patch adds the driver itself.
The second patch adds the DT binding documentation

Changes in v8:
 - renamed the driver sun4i as the PWM IP is different in the next sunxi SoCs
 - Took into account comments from Thierry

Changes in v9:
 - moved from using a mutex to a spinlock

Changes in v10:
 - rebased on v3.18
 - corrected the module name in Kconfig
 - Added dependancy on HAS_IOMEM and COMMON_CLK
 - changes clk_rate in sun4i_pwm_config() to be a u64 to avoid unnecessary
   casting
 - removed unnecessary braces

Alexandre Belloni (2):
  pwm: Add Allwinner SoC support
  pwm: sunxi: document OF bindings

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
 create mode 100644 drivers/pwm/pwm-sun4i.c

-- 
2.1.0
