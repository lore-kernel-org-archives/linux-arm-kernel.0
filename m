From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  6 Aug 2014 03:18:24 +0200
Subject: [RFC 0/8] DPCM with simple-card support for Kirkwood
Message-ID: <1407287912-19447-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

30 June you posted your code to implement DPCM for kirkwood-i2s,
making it possible to use both I2S and SPDIF at the same time.

It has taken me a while, but i now have this patch on 3.16-rc6, and
i've extended simple-card to support DPCM. I've tested it on a
kirkwood based HP T5325, which only makes use of the I2S backend.

Please could you take a look and see if this helps to unblock getting
your Cubox support into mainline.

The code is also here

https://github.com/lunn/linux.git v3.16-rc6-rmk-dpcm 

Thanks
	Andrew

Andrew Lunn (7):
  ASoC: simple-card: Make mclk setting a dai link property
  ARM: Kirkwood: Update sound DT node to reflect DPCM support
  ASoC: dt: Parse DPCM properties
  ASoC: simple-card: Don't set DAI format for dynamic DAIs
  ASoC: dt: Allow the platform name to be set for a DAI
  ASoC: simple-card: Allow use of snd-soc-dummy as codec
  ARM: Kirkwood: Describe DPCM audio support in DT

Russell King (1):
  ASoC: kirkwood: add DPCM support

 .../devicetree/bindings/sound/simple-card.txt      |  11 +-
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |  39 +++-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  37 +++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 include/sound/soc.h                                |   8 +
 sound/soc/generic/simple-card.c                    | 140 +++++++-----
 sound/soc/kirkwood/kirkwood-i2s.c                  | 244 ++++++++++++++-------
 sound/soc/kirkwood/kirkwood.h                      |  20 ++
 sound/soc/soc-core.c                               |  29 +++
 9 files changed, 380 insertions(+), 150 deletions(-)

-- 
2.0.1
