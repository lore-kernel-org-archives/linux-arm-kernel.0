From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 05:00:25 +0900
Subject: [GIT PULL 05/10] Samsung common clk audio for v3.11
Message-ID: <51C0BC59.10907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 166bc934f54cef4588fc141e709e376244e70106:

   Merge branch 'v3.11-next/s3c24xx-dt-2' into v3.11-next/dt-n-clk-audio 
(2013-06-19 03:27:44 +0900)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/common-clk-audio

for you to fetch changes up to 79d743c177f99d6854e152d9e7fac5bbbeb7c25e:

   clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2 
(2013-06-19 03:28:43 +0900)

----------------------------------------------------------------
based on exynos-dt-2 and s3c24xx-dt-2
- use #include for all Samsung DT
- add clk for exynos audio subsystem (audss) and i2s
- support audss and i2s for exynos5250

----------------------------------------------------------------
Padmavathi Venna (6):
       ARM: dts: use #include for all device trees for Samsung
       clk: samsung: register audio subsystem clocks using common clock 
framework
       ARM: dts: add Exynos audio subsystem clock controller node
       ARM: dts: add clock provider information for i2s controllers in 
Exynos5250
       ARM: dts: Update Samsung I2S documentation
       clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2

  .../devicetree/bindings/clock/clk-exynos-audss.txt |  64 ++++++++++
  .../devicetree/bindings/sound/samsung-i2s.txt      |  46 +++----
  arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
  arch/arm/boot/dts/exynos4210-origen.dts            |   2 +-
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   2 +-
  arch/arm/boot/dts/exynos4210-trats.dts             |   2 +-
  arch/arm/boot/dts/exynos4210-universal_c210.dts    |   2 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |   4 +-
  arch/arm/boot/dts/exynos4212.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   2 +-
  arch/arm/boot/dts/exynos4412.dtsi                  |   2 +-
  arch/arm/boot/dts/exynos4x12.dtsi                  |   4 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +-
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +-
  arch/arm/boot/dts/exynos5250-snow.dts              |   4 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |  20 +++-
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |   2 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   2 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
  arch/arm/boot/dts/s3c2416-smdk2416.dts             |   2 +-
  arch/arm/boot/dts/s3c2416.dtsi                     |   4 +-
  arch/arm/boot/dts/s3c24xx.dtsi                     |   2 +-
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos-audss.c             | 133 
+++++++++++++++++++++
  drivers/clk/samsung/clk-exynos5250.c               |   5 +-
  include/dt-bindings/clk/exynos-audss-clk.h         |  25 ++++
  28 files changed, 288 insertions(+), 56 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/clock/clk-exynos-audss.txt
  create mode 100644 drivers/clk/samsung/clk-exynos-audss.c
  create mode 100644 include/dt-bindings/clk/exynos-audss-clk.h
