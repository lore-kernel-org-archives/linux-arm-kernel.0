From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 06 Dec 2012 09:20:35 +0530
Subject: [PATCH V2 0/2] ASoC: Samsung: Remove platform device support
Message-ID: <1354765837-3469-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V1:
	- Renamed all samsung based audio platform names with the corresponding
	  cpu dai name
	- Register the dma device in the corresponding samsung cpu dai driver
	- Deleted "samsung_asoc_dma" platform device from devs.c
	- Deleted the "samsung_asoc_dma" platfrom device entry from the list of
	  registered platform devices in the legacy platforms.
	- Renamed the function name from samsung_dma_platform_register to
	  asoc_dma_platform_register
	- Added binding documentation for new device tree binding

Padmavathi Venna (2):
  ASoC: Samsung: Do not register samsung audio dma device as pdev
  ASoC: SMDK: WM8994: Add device tree support for machine file

 .../bindings/sound/samsung,smdk-wm8994.txt         |   14 +++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   12 ++++++++
 arch/arm/mach-exynos/mach-armlex4210.c             |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c               |    1 -
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    1 -
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c              |    1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    1 -
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    1 -
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    1 -
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    1 -
 arch/arm/plat-samsung/devs.c                       |    9 ------
 arch/arm/plat-samsung/include/plat/devs.h          |    1 -
 sound/soc/samsung/ac97.c                           |   10 ++++++-
 sound/soc/samsung/bells.c                          |    6 ++--
 sound/soc/samsung/dma.c                            |   24 ++++------------
 sound/soc/samsung/dma.h                            |    3 ++
 sound/soc/samsung/goni_wm8994.c                    |    2 +-
 sound/soc/samsung/h1940_uda1380.c                  |    2 +-
 sound/soc/samsung/i2s.c                            |    4 ++
 sound/soc/samsung/jive_wm8750.c                    |    2 +-
 sound/soc/samsung/littlemill.c                     |    2 +-
 sound/soc/samsung/ln2440sbc_alc650.c               |    2 +-
 sound/soc/samsung/lowland.c                        |    2 +-
 sound/soc/samsung/neo1973_wm8753.c                 |    2 +-
 sound/soc/samsung/pcm.c                            |    9 ++++++
 sound/soc/samsung/rx1950_uda1380.c                 |    2 +-
 sound/soc/samsung/s3c2412-i2s.c                    |   20 ++++++++++++-
 sound/soc/samsung/s3c24xx-i2s.c                    |   20 ++++++++++++-
 sound/soc/samsung/s3c24xx_simtec_hermes.c          |    2 +-
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c     |    2 +-
 sound/soc/samsung/s3c24xx_uda134x.c                |    2 +-
 sound/soc/samsung/smartq_wm8987.c                  |    2 +-
 sound/soc/samsung/smdk2443_wm9710.c                |    2 +-
 sound/soc/samsung/smdk_spdif.c                     |    2 +-
 sound/soc/samsung/smdk_wm8580.c                    |    6 ++--
 sound/soc/samsung/smdk_wm8580pcm.c                 |    2 +-
 sound/soc/samsung/smdk_wm8994.c                    |   30 ++++++++++++++++++-
 sound/soc/samsung/smdk_wm8994pcm.c                 |    2 +-
 sound/soc/samsung/smdk_wm9713.c                    |    2 +-
 sound/soc/samsung/spdif.c                          |   10 ++++++-
 sound/soc/samsung/speyside.c                       |    2 +-
 sound/soc/samsung/tobermory.c                      |    2 +-
 47 files changed, 157 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt

-- 
1.7.4.4
