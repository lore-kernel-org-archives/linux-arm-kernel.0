From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 20 Jul 2018 11:00:13 -0500
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.19 (redo)
Message-ID: <7ha7ql6goi.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Here's the re-do of the pull that was missing Signed-off-by tags,
pointed out by Stephen Rothwell.

Kevin



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-1

for you to fetch changes up to 89803e8b26569bdf5798f8745a4c708bf9360ee6:

  ARM64: dts: meson-axg: add pdm pins (2018-07-20 08:18:37 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.19
- new SoC: S805x
- new board: S805x-based P241 board from Amlogic
- AXG: add ADC support w/buttons, add pins for PDM, SPDIF
- AXG: s400 board: preliminary support for audio
- GX: nanopi-k2: add HDMI, CEC, CVBS support

----------------------------------------------------------------
Jerome Brunet (9):
      ARM64: dts: meson-axg: add s400 microphone card leds
      ARM64: dts: meson-axg: add s400 main 12v supply
      ARM64: dts: meson-axg: add s400 speaker amplifier
      ARM64: dts: meson-axg: add spdif output pins
      ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
      ARM64: dts: meson-axg: add adc buttons the S400
      ARM64: dts: meson-axg: remove spdif out from gpio a7
      ARM64: dts: meson-axg: add spdif input pins
      ARM64: dts: meson-axg: add pdm pins

Martin Blumenstingl (2):
      ARM64: dts: meson: enable the saradc node in meson-gx-p23x-q20x.dtsi
      ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each board's .dts

Neil Armstrong (3):
      ARM64: dts: meson-gxbb-nanopi-k2: Add HDMI, CEC and CVBS nodes
      dt-bindings: amlogic: Add support for GXL S805X and the P241 board
      ARM64: dts: add S805X based P241 board

Viresh Kumar (1):
      ARM64: dts: amlogic: Add missing cooling device properties for CPUs

Xingyu Chen (1):
      ARM64: dts: meson-axg: add saradc support

 Documentation/devicetree/bindings/arm/amlogic.txt     |   6 ++++
 arch/arm64/boot/dts/amlogic/Makefile                  |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts        | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi            | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi   |  17 ++++++---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts  |  48 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts  | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts  |  15 +++-----
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts  |   7 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts |  24 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts        |  15 +++-----
 arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts        |   7 ++++
 12 files changed, 570 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
