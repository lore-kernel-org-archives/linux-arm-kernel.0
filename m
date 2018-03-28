From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 28 Mar 2018 11:01:27 +0800
Subject: [PATCH v3 0/3] ARM64: dts: meson-axg: add AO clock driver
Message-ID: <20180328030130.240336-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  These patches try to add AO clock driver for the Amlogic's
AXG SoC, while adding this driver, we found the pclk for uart AO
controller was wrong, so fix it here.
  Note, this patch actually depend on AO clock driver[2]
Please take these patches untill AO clock driver is merged.

changes since v2 at [1]: 
 - previous the DTS patches sit in two seperate series, merge them
   into one patch set.
 
changes since v1 at [0]: 
 -

[0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan at amlogic.com
[1] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
  https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan at amlogic.com
[2] https://lkml.kernel.org/r/20180328025050.221585-1-yixun.lan at amlogic.com


Qiufang Dai (1):
  arm64: dts: meson-axg: add AO clock driver DT info

Yixun Lan (2):
  ARM64: dts: meson-axg: add an 32K alt aoclk
  ARM64: dts: meson: fix clock source of the pclk for UART_AO

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 23 +++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  4 ++--
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.15.1
