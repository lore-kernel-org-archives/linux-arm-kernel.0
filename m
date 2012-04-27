From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 17:13:30 +0530
Subject: [RFC 0/5] pinctrl: SPEAr Updates
Message-ID: <cover.1335526926.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset mainly focuses on providing support to configure SPEAr pads as
gpios. For this i have added a gpiolib based driver and few changes in other
SPEAr pinctrl drivers.

It also contains minor fixes.

I haven't tested it till now, only compile tested.
I wanted to get a first level of review, so posting this set.

One thing currently broken is: Passing gpio base via DT.

Viresh Kumar (5):
  pinctrl: SPEAr: Don't set all non muxreg bits on pinctrl_disable
  pinctrl: SPEAr1310: Fix pin numbers for clcd_high_res
  pinctrl: SPEAr: Add plgpio driver
  pinctrl: SPEAr: Add gpio ranges support
  SPEAr: Add plgpio node in device tree dtsi files

 arch/arm/boot/dts/spear1310.dtsi          |   16 +
 arch/arm/boot/dts/spear1340.dtsi          |   15 +
 arch/arm/boot/dts/spear310.dtsi           |   14 +
 arch/arm/boot/dts/spear320.dtsi           |   15 +
 drivers/pinctrl/spear/Kconfig             |   11 +
 drivers/pinctrl/spear/Makefile            |    1 +
 drivers/pinctrl/spear/pinctrl-plgpio.c    |  736 ++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear.c     |   98 +++-
 drivers/pinctrl/spear/pinctrl-spear.h     |   15 +
 drivers/pinctrl/spear/pinctrl-spear1310.c |  813 ++++++++++++++++++++++++++++-
 drivers/pinctrl/spear/pinctrl-spear1340.c |    9 +
 drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c  |  121 +++++
 15 files changed, 1857 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pinctrl/spear/pinctrl-plgpio.c

-- 
1.7.9
