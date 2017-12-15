From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 15 Dec 2017 10:10:12 +0800
Subject: [PATCH v3 0/2] Add ethernet support for Meson-AXG SoC
Message-ID: <20171215021014.231308-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series try to add support for the ethernet MAC controller
found in Meson-AXG SoC, and also enable it in the S400 board.

Changes in v3 since [4]:
 - put clock DT info in soc.dtsi
 - separate DT for 'add support for the controller' vs 'enable in board'

Changes in v2 since [1]:
 - rebase to kevin's v4.16/dt64 branch
 - add Neil's Reviewed-by
 - move clock info to board.dts instead of in soc.dtsi
 - drop "meson-axg-dwmac" compatible string, since we didn't use this
   we could re-add it later when we really need.
 - note: to make ethernet work properly,it depend on clock & pinctrl[2],
   to compile the DTS, the patch [3] is required.
   the code part will be taken via clock & pinctrl subsystem tree.

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005301.html

[4]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005768.html

[2]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005735.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005694.html

[3]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005738.html

Yixun Lan (2):
  ARM64: dts: meson-axg: add ethernet mac controller
  ARM64: dts: meson-axg: enable ethernet for A113D S400 board

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  7 ++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 54 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.15.1
