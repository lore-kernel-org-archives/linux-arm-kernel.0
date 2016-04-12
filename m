From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:49 +0100
Subject: [PATCH v2 00/13] ARM: dts: Add DB600c support.
Message-ID: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

This patchset adds support to DB600c which is based on APQ8064.

With this patchset, except spi I was able to test all the below features
on this board on top of v4.6-rc3.
1> i2c
2> spi
3> sd/mmc with card detect
4> eMMC
5> USB
6> SATA
7> on board Ethernet based on PCIE.
8> user and activity leds.
9> on board Magnetometer

This patchset also has a fix to i2c/spi pinctrls which was not set correctly
in my previous apq8064 patches, I have verified this patchset with eeprom and
sensors on the board, you might want to take that patch in next rc.

Changes since v1:
	- renamed the dts and compatible strings according to the discussion.
	- fixed/renamed led labels as suggeste by Rob, Nico and others.
	- Added Acks for Bjorn
	- Added Magnetometer support.
	- Split the pinconfs to seperate file as suggested by Bjorn
	- Remove activity leds default triggers, as it was not clear
	 which trigger was correct according to 96boards specs.
	 Can be added once we fix that.

Thanks,
srini

Srinivas Kandagatla (13):
  ARM: dts: apq8064: fix the pinctrls for i2c and spi
  ARM: dts: apq8064: add support to gsbi1 uart
  ARM: dts: apq8064: add gsbi7 i2c support
  ARM: dts: db600c: add board support with serial
  ARM: dts: db600c: add pmic regulator supplies
  ARM: dts: db600c: Add eMMC and SD card support
  ARM: dts: db600c: add usb support
  ARM: dts: db600c: add pcie support
  ARM: dts: db600c: add on board sata support.
  ARM: dts: db600c: Add on board leds support
  ARM: dts: db600c: add i2c support
  ARM: dts: db600c: add spi support
  ARM: dts: db600c: add support to magnetometer

 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   |  52 +++
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 349 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           |  39 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  41 ++-
 5 files changed, 476 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts

-- 
2.5.0
