From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 May 2015 14:47:50 +0200
Subject: [PATCH v5 0/2] iio: adc: vf610: respect ADC clocking limitations
Message-ID: <1432730872-14325-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This revision is basically the same as v4, just some wording
improvements. I would appriciate an Ack for the device tree part.
The clock limit values are defined in the data sheet and could
be different per SoC, hence descirbe the hardware limitation...

Changes since v4:
- Remove fussy english
- Drop "iio: adc: vf610: use ADC clock within specification" since
  that patch is already applied

Changes since v3:
- Move device tree bindings to driver changes

Changes since v2:
- Add sysfs ABI documentation
- Fix commit message spelling errors

Changes since v1:
- Use ext_info for conversion mode

Stefan Agner (2):
  iio: adc: vf610: implement configurable conversion modes
  ARM: dts: add property for maximum ADC clock frequencies

 Documentation/ABI/testing/sysfs-bus-iio-vf610      |   7 +
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |   4 +
 drivers/iio/adc/vf610_adc.c                        | 146 +++++++++++++++------
 4 files changed, 124 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-vf610

-- 
2.4.1
