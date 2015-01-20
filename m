From: stefan@agner.ch (Stefan Agner)
Date: Tue, 20 Jan 2015 17:02:00 +0100
Subject: [PATCH 0/3] iio: adc: vf610: respect ADC clocking limitations
Message-ID: <1421769723-28677-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Respect ADC clocking limitations which lead to bogous reading on
500MHz clocked Vybrid SoC's. Additionally, also implement a
sysfs-property to configure the conversion mode available in this
ADC peripherial.

Stefan Agner (3):
  iio: adc: vf610: use ADC clock within specification
  iio: adc: vf610: implement configurable conversion modes
  ARM: dts: add property for maximum ADC clock frequencies

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |   4 +
 drivers/iio/adc/vf610_adc.c                        | 175 +++++++++++++++++----
 3 files changed, 156 insertions(+), 32 deletions(-)

-- 
2.2.2
