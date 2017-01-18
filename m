From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 18 Jan 2017 11:12:18 +0530
Subject: [PATCH 0/3] Use macros for pinctrl configuration on Exynos7
References: <CGME20170118053944epcas1p1bed1518b3ba444434bfbe4048b6fe4bd@epcas1p1.samsung.com>
Message-ID: <1484718141-28785-1-git-send-email-pankaj.dubey@samsung.com>
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
