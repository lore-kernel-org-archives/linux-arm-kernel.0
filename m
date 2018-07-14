From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 21:37:20 +0200
Subject: [PATCH v2 0/5] ARM64: amlogic: add support for the S905W and two
 boards
Message-ID: <20180714193725.17837-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to to add support for the Amlogic S905W SoC
along with Amlogic's P281 development board and the Tanix TX3 Mini (which
both use the S905W SoC).

I am sending this as request-for-comments because I would like to get
feedback specifically on:
- the naming of the new vendor "Oranth" and their brand "Tanix". more
  information regarding their relation can be found in patch #1
- I do not have access to the P281 development board (nor any
  documentation apart from what is available in Amlogic's GPL kernel
  sources). thus it would be great if someone from Amlogic could confirm
  that my .dts is working
- the S905W SoC is a cost-reduced version of the S905X SoC. I have
  documented the differences that I am aware of in patch #2. none of
  these changes require adjustments to any existing driver/binding
  because these changes are either handled in the SCPI firmware (CPU
  frequency and DDR interface) or there is no Linux support for them
  yet (4k HDMI resolutions and the HW video decoder)


changes since RfC v1 at [0]:
- dropped RfC prefix
- collected Rob's Reviewed-by on patches 1-3
- dropped meson-gxl-s905w.dtsi and include meson-gxl-s905x.dtsi instead
  as suggested by Kevin and as already done with the new P241 board
  (which uses the GXL S805X SoC instead of S905W though)
- rebased on top of Kevin's v4.19/dt64 branch to apply cleanly on top
  of f51b3da8f18d50 ("ARM64: dts: add S805X based P241 board")

[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-June/007517.html


Martin Blumenstingl (5):
  dt-bindings: add vendor prefix for Shenzhen Oranth Technology Co.,
    Ltd.
  dt-bindings: arm: amlogic: Add support for GXL S905W and the P281
    board
  dt-bindings: arm: amlogic: Add support for the Oranth Tanix TX3 Mini
  ARM64: dts: meson-gxl: add support for the S905W SoC and the P281
    board
  ARM64: dts: meson-gxl: add support for the Oranth Tanix TX3 Mini

 .../devicetree/bindings/arm/amlogic.txt       |  7 ++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  2 ++
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts | 22 +++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  | 22 +++++++++++++++++++
 5 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts

-- 
2.18.0
