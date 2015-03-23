From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 23 Mar 2015 16:09:02 +0100
Subject: [GIT PULL] at91: dt for 4.1 #2
Message-ID: <1427123342-32683-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another batch of DT changes with several little additions. The bulk of it is
about LCD and the addition of nodes for its new driver.
It is based on top of the "at91-dt" tag that you already have.

Thanks, best regards,

The following changes since commit 35762a624f82dbea7c62177bf3ef0cde0d0f84bc:

  ARM: at91/dt: sama5d4: add ISI dt support (2015-03-04 18:36:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-dt2

for you to fetch changes up to 3c42ae3645a7fd2605453de9947629fb7b26c95f:

  ARM: at91/dt: sama5d4: add rgb777 LCD line configuration (2015-03-23 16:04:16 +0100)

----------------------------------------------------------------
Second batch of DT changes for 4.1:
- RTC nodes for at91sam9x5 boards and at91sam9n12ek
- HLCDC nodes and pin definitions for sama5d3 & sama5d4
- additional uarts for sama5d3

----------------------------------------------------------------
Alexander Stein (1):
      DT: video: atmel_lcdc: Add example of fixed framebuffer memory

Boris Brezillon (5):
      ARM: at91/dt: split sama5d3 lcd pin definitions to match RGB mode configs
      ARM: at91/dt: add alternative pin muxing for sama5d3 lcd pins
      ARM: at91/dt: define the HLCDC node available on sama5d3 SoCs
      ARM: at91/dt: sama5d4: add lcdc pin definitions
      ARM: at91/dt: sama5d4: add hlcdc node

Nicolas Ferre (6):
      ARM: at91/dt: at91sam9x5cm: enable RTC
      ARM: at91/dt: at91sam9n12ek: enable RTC
      ARM: at91/dt: sama5d3: add uart0
      ARM: at91/dt: sama5d3: add uart1 pinctrl definition
      ARM: at91/dt: sama5d4: fix LCD pins for RGB666 format
      ARM: at91/dt: sama5d4: add rgb777 LCD line configuration

 .../devicetree/bindings/video/atmel,lcdc.txt       |  12 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |   4 +
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   4 +
 arch/arm/boot/dts/sama5d3.dtsi                     |  34 ++++
 arch/arm/boot/dts/sama5d3_lcd.dtsi                 | 205 +++++++++++++++++----
 arch/arm/boot/dts/sama5d4.dtsi                     | 150 +++++++++++++++
 6 files changed, 377 insertions(+), 32 deletions(-)

-- 
Nicolas Ferre
