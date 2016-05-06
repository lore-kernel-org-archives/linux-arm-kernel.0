From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:19 -0700
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
Message-ID: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for several more devices, both in the EE domain and in the
AO domain.  Also, add the pins to the corresponding DTS files.

Tested on odroid-c2 and Amlogic P200 boards, and verified with working
ethernet.

Depends on the initial GXBB pinctrl support from Carlo[1].  Also
available in my git tree[2] with all the dependencies included.

Kevin

[1] [PATCH v2 0/4] Amlogic: GXBB: Add pin controller
    http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/426718.html
[2] https://git.kernel.org/cgit/linux/kernel/git/khilman/linux.git/log/?h=amlogic/wip/pinctrl

Kevin Hilman (7):
  pinctrl: amlogic: gxbb: add UART_AO_B, I2C
  pinctrl: amlogic: gxbb: add EMMC and SD pins
  pinctrl: amlogic: gxbb: add more UART pins
  pinctrl amlogic: gxbb: add ethernet pins
  ARM64: dts: amlogic: add pins for EMMC, SD
  ARM64: dts: amlogic: gxbb: pinctrl: add/update UART
  ARM64: dts: amlogic: gxbb: add ethernet

 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  97 +++++++++++-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         | 167 ++++++++++++++++++++-
 4 files changed, 273 insertions(+), 5 deletions(-)

-- 
2.7.4
