From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Fri, 26 Sep 2014 18:43:58 +0530
Subject: [PATCH 0/3] Add SNVS clock gating and clock support to rtc-snvs driver
Message-ID: <cover.1411736171.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series of patches:
(1) Enable clock gating for the SNVS peripheral
(2) Adds SNVS devicetree node for the VF610 platform
(3) Add clock enable and disable support for the 
SNVS peripheral which is required by RTC. 

I would like to ask whether the solution i am
opting for in these set of patches is ok? Is there
another more appropriate solution? I couldn't find
any other piece of code which was enabling the clock
gating for the SNVS peripheral explicitly. Is this 
expected to be taken care of by uboot?

Sanchayan Maity (3):
  ARM: imx: clk-vf610: Add SNVS clock
  ARM: dts: vf610: Add SNVS node
  drivers/rtc/rtc-snvs: Add clock support

 arch/arm/boot/dts/vf610.dtsi            |   15 ++++++++++
 arch/arm/mach-imx/clk-vf610.c           |    1 +
 drivers/rtc/rtc-snvs.c                  |   48 +++++++++++++++++++++++++------
 include/dt-bindings/clock/vf610-clock.h |    3 +-
 4 files changed, 57 insertions(+), 10 deletions(-)

-- 
1.7.9.5
