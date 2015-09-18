From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:29:31 +0100
Subject: [PATCH 00/14] ARM: dts: apq8064 dt cleanups and additions
Message-ID: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are few cleanup and additions to the existing APQ8064 device tree.

Some of the patches are to do with princtrl cleanup which was always not
in the right place and some of the pinctrls were missing.
Other set of patches is to do with adding more devices like rtc rng
and pwr key for pmic 8921.
Last set of patches are related to pwrseq and SD card detect taking Stephens
comments into consideration.

Am resending John Stultz patch which was forgotten in the mailing list.

I have tested these patches on IFC6410.

Thanks,
srini

John Stultz (1):
  devicetree: Add hardware rng entry to qcom-apq8064.dtsi

Srinivas Kandagatla (13):
  ARM: dts: apq8064: remove redundant i2c pinctrl properties
  ARM: dts: ifc6410: remove unnecessary eeprom label
  ARM: dts: qs600: remove unnecessary eeprom label
  ARM: dts: apq8064: add pm8921 rtc
  ARM: dts: apq8064: add pm8921 pwrkey support
  ARM: dts: apq8064: Prefix the gsbi6 uart pins correctly
  ARM: dts: apq8064: add missing gsbi7 uart pinctrl
  ARM: dts: ifc6410: Add missing pinctrl to gsbi7 uart
  ARM: dts: qs600: Add missing pinctrl property for gsbi7 uart
  ARM: dts: ifc6410: Add pwrseq support for WLAN
  ARM: dts: qs600: add pwrseq support to WLAN
  ARM: dts: apq8064-ifc6410: add notify led support.
  ARM: dts: qs600: Add SD card detect support.

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 48 ++++++++++++++++++++---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 60 +++++++++++++++++++++++++----
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 50 +++++++++++++++++++++++-
 3 files changed, 144 insertions(+), 14 deletions(-)

-- 
1.9.1
