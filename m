From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 14 Nov 2012 18:09:07 +0800
Subject: [Patch v6 0/4] ASoC: atmel-ssc: Add pinctrl support and change
 register method
Message-ID: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
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
  - at91sam9g20ek wm8731: match new method of dai and pcm register
  - at91sam9g20ek wm8731: convert to dt support

Bo Shen (4):
  ARM: at91: atmel-ssc: add pinctrl support
  ASoC: atmel-ssc-dai: register dai and pcm directly
  ASoC: atmel-ssc-dai: match new method of dai and pcm register
  ASoC: at91sam9g20ek-wm8731: convert to dt support

 .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     |   26 ++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |   18 +++
 arch/arm/boot/dts/at91sam9263.dtsi                 |   36 +++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   32 +++-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   36 +++++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   26 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   32 +++-
 arch/arm/mach-at91/at91sam9260_devices.c           |    9 --
 arch/arm/mach-at91/board-sam9g20ek.c               |    6 -
 drivers/misc/atmel-ssc.c                           |    8 +
 sound/soc/atmel/Kconfig                            |    3 +-
 sound/soc/atmel/atmel-pcm.c                        |   23 +--
 sound/soc/atmel/atmel-pcm.h                        |    3 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  157 +++++---------------
 sound/soc/atmel/atmel_ssc_dai.h                    |    3 +-
 sound/soc/atmel/sam9g20_wm8731.c                   |   75 +++++++++-
 16 files changed, 328 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-at91sam9g20ek-wm8731-audio.txt

-- 
1.7.9.5
