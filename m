From: peda@axentia.se (Peter Rosin)
Date: Thu, 1 Dec 2016 12:59:07 +0100
Subject: [PATCH 0/2] register atmel-ssc as sound DAI w/o platform driver
Message-ID: <1480593549-6464-1-git-send-email-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

The Atmel SSC is currently not usable as an audio DAI unless someone
registers it with ASoC. This is currently delegated to a platform
driver for every possible audio use, and prevents the SSC from being
used as a cpu DAI with the simple-audio-card driver.

The first patch fixes this.

The second patch simplifies one of these platform drivers, since it
can now rely on the SSC to register itself with ASoC. However, this
may not be a possible simplification for other, older, drivers since
it also requires device tree changes.

Cheers,
Peter

Peter Rosin (2):
  misc: atmel-ssc: register as sound DAI if #sound-dai-cells is present
  ASoC: atmel: tse850: rely on the ssc to register as a cpu dai by
    itself

 .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +
 .../bindings/sound/axentia,tse850-pcm5142.txt      |  5 +--
 drivers/misc/atmel-ssc.c                           | 50 ++++++++++++++++++++++
 include/linux/atmel-ssc.h                          |  1 +
 sound/soc/atmel/tse850-pcm5142.c                   | 23 ++--------
 5 files changed, 58 insertions(+), 23 deletions(-)

-- 
2.1.4
