From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Sep 2016 11:21:49 +0200
Subject: [PATCH 0/6] pinctrl: s3c/samsung: Add header with values used for
 configuration
Message-ID: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Extend previous patchset (v2) [1] to older, legacy platforms.
This depends on v2 of prevoius patchset.


Changes in DTS/DTSI generated with:
sed -i -e 's/samsung,pin-drv = <0>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;/' arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-drv = <2>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;/' arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-drv = <1>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV3>;/' arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-drv = <3>;$/samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;/' arch/arm/boot/dts/s5p*

sed -i -e 's/samsung,pin-pud = <0>;$/samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-pud = <1>;$/samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-pud = <2>;$/samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*

sed -i -e 's/samsung,pin-function = <0>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <2>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_2>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <\(0x\)\?2>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_2>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <\(0x\)\?3>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_3>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <3>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_3>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <4>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_4>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <5>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_5>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <6>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_6>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*
sed -i -e 's/samsung,pin-function = <0xf>;$/samsung,pin-function = <EXYNOS_PIN_FUNC_F>;/' arch/arm/boot/dts/s3c* arch/arm/boot/dts/s5p*


Tested with:
rm -fr dts-old; cp -r out/arch/arm/boot/dts dts-old
rm -fr dts-new; cp -r out/arch/arm/boot/dts dts-new
for i in dts-old/exynos*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done
for i in dts-old/s3c*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done
for i in dts-old/s5p*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done


[1] http://www.spinics.net/lists/devicetree/msg141190.html

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  pinctrl: dt-bindings: samsung: Update documentation with new macros
  pinctrl: dt-bindings: samsung: Add macros for S3C64xx pin
    configuration
  ARM: dts: s3c64xx: Use common macros for pinctrl configuration
  ARM: dts: s5pv210: Use macros for pinctrl configuration
  ARM: dts: s3c2416: Use macros for pinctrl configuration
  ARM: dts: s3c64xx: Use macros for pinctrl configuration

 .../bindings/pinctrl/samsung-pinctrl.txt           |  42 +-
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  38 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 356 ++++++++-------
 arch/arm/boot/dts/s5pv210-aquila.dts               |   4 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             | 476 +++++++++++----------
 include/dt-bindings/pinctrl/samsung.h              |   5 +
 7 files changed, 466 insertions(+), 459 deletions(-)

-- 
1.9.1
