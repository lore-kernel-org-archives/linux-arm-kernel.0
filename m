From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 14 Jul 2015 19:23:21 +0530
Subject: [PATCH v3 0/2] Implement sample time consideration for Vybrid's ADC
Message-ID: <cover.1436880513.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds a dt binding for specifying sample time
for the vybrid adc driver and takes this into account for
sampling frequency calculation and related configuration in
the driver.

The patchset is based on top of Stefan's patches here
http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html

which got recently applied.

Changes since v2:

- Use a default value of 1000ns for sample time in the driver
  if the property is not specified in the device tree.
- Specify the min-sample-time property in the board device tree
  file instead of the top level vfxxx.dtsi file for Vybrid

Changes since v1:

Change from a vendor specific fsl,min-sample-time to non vendor
specific min-sample-time.

Version 2 of the patchset can be found here
https://lkml.org/lkml/2015/6/24/97

Version 1 of the patchset can be found here
http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html

- Sanchayan.

Sanchayan Maity (2):
  iio: adc: vf610: Determine sampling frequencies by using minimum
    sample time
  ARM: dts: vf-colibri: Add property for minimum sample time

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  5 ++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  2 +
 drivers/iio/adc/vf610_adc.c                        | 79 ++++++++++++++++++++--
 3 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.4.5
