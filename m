From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  8 Jun 2015 11:11:59 +0530
Subject: [PATCH v1 0/2] Implement sample time consideration
Message-ID: <cover.1433740528.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds a dt binding for specifying sample time
for the vybrid adc driver and takes this into account for
sampling frequency calculation and related configuration in
the driver.

The patchset is based on top of Stefan's patches here
http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html

which got recently applied. Tested with shawn's for-next
branch.

Regards,
Sanchayan.

Sanchayan Maity (2):
  iio: adc: Determine sampling frequencies by using minimum sample time
  ARM: dts: vfxxx: Add property for minimum sample time

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
 drivers/iio/adc/vf610_adc.c                        | 74 ++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.4.2
