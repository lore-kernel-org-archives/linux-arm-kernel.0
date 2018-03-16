From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 16 Mar 2018 16:08:11 +0900
Subject: [PATCH 0/2] add syscon property to binding document
Message-ID: <20180316070813.17969-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds syscon property for specifying soc-glue core.

The soc-glue core is used for changing the state of S/PDIF signal
output pin to signal output state or Hi-Z state. After resetting of
SoC Hi-Z state is selected.

Currently, we set this mode in local changed U-Boot or some
bootloaders fixedly. This patch removes dependencies of bootloader
from UniPhier audio system driver.

Katsuhiro Suzuki (2):
  ASoC: uniphier: add syscon property to binding document
  ASoC: uniphier: add syscon property for UniPhier sound system

 .../devicetree/bindings/sound/uniphier,aio.txt      |  8 ++++++++
 sound/soc/uniphier/aio-core.c                       | 21 +++++++++++++++++++++
 sound/soc/uniphier/aio-cpu.c                        | 11 +++++++++++
 sound/soc/uniphier/aio-reg.h                        |  3 +++
 sound/soc/uniphier/aio.h                            |  2 ++
 5 files changed, 45 insertions(+)

-- 
2.16.2
