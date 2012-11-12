From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 12 Nov 2012 15:40:24 +0800
Subject: [PATCH v5 0/3] Add pinctrl support and enable audio
Message-ID: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is based on linux next master branch
The detail information as following:
  Git: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  Branch: master
  Commit ID: 75e0ebabd87048b91e4189b90d4af8ef565115db

Detail information about implement as following:
  - atmel ssc: add pinctrl support
  - atmel ssc dai: register dai and pcm directly
  - at91sam9g20ek wm8731: convert to dt support

Bo Shen (3):
  ARM: at91: atmel-ssc: add pinctrl support
  ASoC: atmel-ssc-dai: register dai and pcm directly
  ASoC: at91sam9g20ek-wm8731: convert to dt support

 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 +++
 arch/arm/boot/dts/at91sam9260.dtsi                 |   18 ++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   36 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   34 ++-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   36 ++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   26 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   32 ++-
 arch/arm/mach-at91/at91sam9260_devices.c           |    9 -
 arch/arm/mach-at91/board-sam9g20ek.c               |    8 +-
 drivers/misc/atmel-ssc.c                           |    8 +
 sound/soc/atmel/Kconfig                            |    3 +-
 sound/soc/atmel/atmel-pcm.c                        |   23 +-
 sound/soc/atmel/atmel-pcm.h                        |    3 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  228 +++++---------------
 sound/soc/atmel/atmel_ssc_dai.h                    |    1 +
 sound/soc/atmel/sam9g20_wm8731.c                   |   89 +++++++-
 16 files changed, 357 insertions(+), 223 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt

-- 
1.7.9.5
