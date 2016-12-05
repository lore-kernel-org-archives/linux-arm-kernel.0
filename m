From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon,  5 Dec 2016 03:42:36 +0200
Subject: [PATCH 0/3] pwm: lpc32xx: switch driver to one phandle argument for
 PWM consumers
Message-ID: <20161205014237.1689-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds private of_xlate() function to process one argument given
along with a PWM phandle. LPC32xx SoCs have two independent single channel
PWM controllers, the argument is used as a description of PWM output
frequency, see previous discussion here:

  http://www.spinics.net/lists/arm-kernel/msg534068.html

The changes on actual board dts files are not needed at the moment, because
all LPC32xx boards in upstream don't describe any PWM consumers.

Vladimir Zapolskiy (3):
  dt: pwm: lpc32xx: add description of clocks and #pwm-cells properties
  pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
  pwm: lpc32xx: remove handling of PWM channels

 .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  7 +++++
 drivers/pwm/pwm-lpc32xx.c                          | 36 +++++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.10.2
