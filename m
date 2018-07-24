From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:24 +0200
Subject: [PATCH 00/14] arm64: dts: meson-axg: add audio support
Message-ID: <20180724125238.14567-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of this patchset is to add the audio devices on amlogic's
AXG SoCs.

Some codecs require some power supplies. This is why the 3 first patches
deal with the S400 power supplies, even if some are not related to audio.

In term of dependency, apart from the clock bindings you have already
pulled for your second PR to arm-soc, this patchset requires the ARB
reset bindings [0] for patch 5. I don't know if Philip can make it
available somewhere ?

Of course, if the dependencies make this patchset too complicated to
merge in this cycle, I'll resubmit once the next rc1 is out.

Jerome Brunet (14):
  arm64: dts: meson-axg: improve power supplies description
  arm64: dts: meson-axg: add vcc 5v regulator on the s400
  arm64: dts: meson-axg: add usb power regulator
  arm64: dts: meson-axg: add audio arb reset controller
  arm64: dts: meson-axg: add audio fifos
  arm64: dts: meson-axg: add spdifout
  arm64: dts: meson-axg: add tdmin formatters
  arm64: dts: meson-axg: add tdmout formatters
  arm64: dts: meson-axg: add tdm interfaces
  arm64: dts: meson-axg: add linein codec
  arm64: dts: meson-axg: add lineout codec
  arm64: dts: meson-axg: add spdif-dit codec
  arm64: dts: meson-axg: s400: enable audio devices
  arm64: dts: meson-axg: add s400 sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 237 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 216 ++++++++++++++++
 2 files changed, 453 insertions(+)

-- 
2.17.1
