From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 25 Feb 2015 22:57:58 +0100
Subject: [PATCH 0/4] Armada 38x and 370 audio
In-Reply-To: <y>
References: <y>
Message-ID: <1424901482-3809-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I send a series of patches adding I2S - S/PDIF support for Marvell Armada 38x
SoC. It is same controller as in Armada 370, however two quirks had to be taken
into consideration:

* new PLL frequency setting

* exceptive pinout of I2S and S/PDIF formats

Kirkwood-i2s driver was enhanced with obtaining mem resources by name. Sound
interface was enabled for Armada 385 DB board, using simple-card DT binding for
both I2S and S/PDIF. In addition to that minor fix was applied for Armada 370
audio DT description (stable-CC'ed).

Any comments and remarks are welcome.

Best regards,
Marcin

Marcin Wojtas (4):
  ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
  ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
  ARM: mvebu: add audio support to Armada 385 DB
  ARM: mvebu: fix routing for analog audio input of Armada 370 DB
    platform

 .../devicetree/bindings/sound/mvebu-audio.txt      |  14 ++-
 arch/arm/boot/dts/armada-370-db.dts                |   2 +-
 arch/arm/boot/dts/armada-388-db.dts                |  69 +++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  17 +++
 sound/soc/kirkwood/kirkwood-i2s.c                  | 132 ++++++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                      |   2 +
 6 files changed, 232 insertions(+), 4 deletions(-)

-- 
1.8.3.1
