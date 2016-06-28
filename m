From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Tue, 28 Jun 2016 13:10:33 +0530
Subject: [PATCH v4 0/3] Add Broadcom iproc-static-adc controller driver
Message-ID: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains initial driver for Broadcom's
iproc static adc controller. The patchset is based on v4.7-rc1
tag and its tested on Broadcom Cygnus SoC.

The patches can be fetched from iproc-adc-v4 branch of
https://github.com/Broadcom/arm64-linux.git


Changes since v3:
 - Assigned indio_dev->name to be iproc-static-adc.
 - Modified Module Author to include the name and email address.
 - Modified DT binding document to include reference to IIO core
   docs for property io-channel-ranges.

Changes since v2:
 - Addressed various comments given by Jonathan Cameron and
   Peter Meerwald-Stadler on driver source code related to linux
   coding style and clean-up of code. Lot of source code change
   happened especially due to redefining the #defines.
 - Added code to support IIO_CHAN_INFO_SCALE mask to return
   scale value in iproc_adc_read_raw().
 - Removed #address-cells, #size-cells properties in DT binding
   document and dts file as adc will not have any child nodes as
   noticed by Rob Herring.

Changes since v1:
 - Modified Kconfig file to add more informative information
   in Broadcom Adc driver configuration menu.
 - Added Broadcom Adc driver menu config in the alphabetical
   order in Kconfig
 - Addressed various comments given by Peter Meerwald-Stadler
   on driver source code, Including issues related to linux
   coding style and race conditions.

Raveendra Padasalagi (3):
  Documentation: DT: Add iproc-static-adc binding
  iio: Add driver for Broadcom iproc-static-adc
  ARM:dts-Add dt node for Broadcom iproc-static-adc

 .../bindings/iio/adc/brcm,iproc-static-adc.txt     |  41 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  11 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/bcm_iproc_adc.c                    | 644 +++++++++++++++++++++
 5 files changed, 709 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
 create mode 100644 drivers/iio/adc/bcm_iproc_adc.c

-- 
1.9.1
