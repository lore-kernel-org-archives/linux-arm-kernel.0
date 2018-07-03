From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Tue, 3 Jul 2018 17:56:29 +0300
Subject: [PATCH 0/2] ASoC: atmel-i2s: Remove unnecessary audio PLL clock
Message-ID: <20180703145631.15246-1-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Quentin Schulz's patch:
commit 1a1a36d72e3d ("clk: at91: clk-generated: make gclk determine audio_pll rate")

the generated clock (gclk) itself is able to configure the audio PLL clock
(aclk). For this reason, the I2S driver no longer needs to set aclk,
but only gclk.
This patchet removes all references to the audio PLL clock from the
driver and updates the driver's bindings.

Codrin Ciubotariu (2):
  ASoC: atmel-i2s: Remove unnecessary audio PLL clock (aclk)
  ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk

 .../devicetree/bindings/sound/atmel-i2s.txt   | 11 ++---
 sound/soc/atmel/atmel-i2s.c                   | 46 +++----------------
 2 files changed, 12 insertions(+), 45 deletions(-)

-- 
2.17.1
