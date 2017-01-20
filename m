From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 20 Jan 2017 09:49:54 +0530
Subject: [PATCH v2 0/3] Use macros for pinctrl configuration on Exynos7
References: <CGME20170120041717epcas5p152b88433819396e114a42b0f82af3f7a@epcas5p1.samsung.com>
Message-ID: <1484885997-21004-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently Exynos7 DTSi files are using hard-coded values for pinctrl
configurations such as pin-function, pin-pud and pin-drv. These hard
coded values are difficult to understand without datasheet, lets use
macros for such configurations.

While doing this observed that Exynos7 has different drive strengths
values *ONLY* for FSYS1 blocks pins, so adding new macro definition
for the same in patch[2/3]

Also some of sd0_xxxx pin definition is using drive strength as 0x3 but
as per datasheet of Exynos7, FSYS1 block's pin does not support 0x3 value
for drive strenth so fixing the same in patch[1/3].

I have verified these patches for boot on Exynos7 based espresso board.

Changes since v1:
 - Fixed drive strength of pmic_irq pins as pointed by Krzysztof
 - Included Alim's R-o-B tag

Pankaj Dubey (3):
  arm64: dts: exynos: Fix drive strength of sd0_xxx pin definitions
  pinctrl: dt-bindings: samsung: Add Exynos7 specific pinctrl macro
    definitions
  arm64: dts: exynos: Use macros for pinctrl configuration on Exynos7

 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   4 +-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi | 302 ++++++++++++------------
 include/dt-bindings/pinctrl/samsung.h           |   8 +
 3 files changed, 162 insertions(+), 152 deletions(-)

-- 
2.7.4
