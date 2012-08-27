From: shachimi@adeneo-embedded.com (HACHIMI Samir)
Date: Mon, 27 Aug 2012 17:34:30 +0200
Subject: [PATCH v2 0/2] imx6q: pwm: Activate stop_mode and configure pinmux
Message-ID: <3465D313FDFB824F9A9C8CD24FA4F6BCB4ACFC@frontmail.adetel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samir Hachimi <shachimi@adeneo-embedded.com>

This patch series enables support for pwm driver on imx6q SoC. The first
patch of the series configure the pinctrl for pwm in device-tree. Actually
they are several pin who can be set to pwmO for each pwm, so I assume that
all of them must be enabled when configuring pin.
The second patch activate stop_enable mode and unset the enable bit during
configuration of pwm, and set the enable bit in pwm CR register during enable.

Changes since v1:
Remove default pwm pinmux configuration in DT as Shawn and Matt suggested.
Now, pwm used pwm's clocks properties to configure pwm's clock.
Need Shawn's patch '[PATCH v2 0/4] Move imx6q/28/23 clock lookup over to device tree' to work.
Use Beno??t's '[PATCH] pwm-imx: Fix config / enable / disable' (un)setting the cr enable bit to enable/disable pwm.
The second patch used driver_data instead of cpu_is_xxx macros, to check used architecture and enabled stop_enable mode.


Samir Hachimi (2):
  Add clock look-up for pwm.
  Enable Stop_enable mode during configuration of pwm.

 arch/arm/boot/dts/imx6q.dtsi |   68 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-imx.c        |   59 ++++++++++++++++++++++++++----------
 2 files changed, 111 insertions(+), 16 deletions(-)
