From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Mon, 27 Oct 2014 11:41:07 +0530
Subject: [PATCH 0/4] Arndale: Adding Sound Machine Driver for ALC5631 Codec
Message-ID: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add machine driver to instantiate I2S based realtek's
 ALC5631 based sound card on Arndale board.

There are other variants of Audio Daughter Cards for Arndale
Board for which support already exists but there is no support for
Realtek's alc5631 codec based card hence support for ALC5631 based
machine driver is being added.

Most of the code has been pulled from insignal's git for Arndale and
modified to suit the maintain syntax. Machine driver has been made
DT compatible.

Krishna Mohan Dani (4):
  ASoC: ALC5631: Add device tree binding documentation
  Sound: Samsung: Add sound card machine driver for Arndale Board
  Sound: Kconfig: Adding the description of the codec
  Sound: DT: Adding Device Tree compatibility to Realtek's ALC5631
    codec driver

 Documentation/devicetree/bindings/sound/rt5631.txt |   41 +++++
 sound/soc/codecs/Kconfig                           |    3 +-
 sound/soc/codecs/rt5631.c                          |   11 ++
 sound/soc/samsung/Kconfig                          |    6 +
 sound/soc/samsung/Makefile                         |    2 +
 sound/soc/samsung/arndale_rt5631.c                 |  167 ++++++++++++++++++++
 6 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt
 create mode 100644 sound/soc/samsung/arndale_rt5631.c

-- 
1.7.9.5
