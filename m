From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue,  9 Feb 2016 10:56:04 +0530
Subject: [PATCH v1 0/2] Add DAC driver support for Vybrid SoC
Message-ID: <cover.1454939346.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds support for the DAC peripheral on Vybrid SoC.
Patchset is based on top of shawn's for-next branch and has been
tested on a Toradex Colibri VF50 module.

I had one query as to whether my implementation under the
IIO_CHAN_INFO_SCALE correct? I am not clear on exactly on how
the voltage_scale parameter is suppose to be set and used.

Feedbacks and comments most welcome.

Thanks & Regards,
Sanchayan.


Sanchayan Maity (2):
  ARM: dts: vfxxx: Add DAC node for Vybrid SoC
  iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC

 .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  18 ++
 drivers/iio/dac/Kconfig                            |   8 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/vf610_dac.c                        | 302 +++++++++++++++++++++
 5 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 create mode 100644 drivers/iio/dac/vf610_dac.c

-- 
2.7.1
