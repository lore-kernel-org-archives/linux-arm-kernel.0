From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 23 Feb 2018 10:17:15 +0900
Subject: [PATCH v2 0/2] ASoC: add support for ROHM BD28623 codec
Message-ID: <20180223011717.2799-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ROHM BD28623MUV class D speaker
amplifier codec driver.

This driver only refers information of HW specification document
that can be derivered at website of ROHM.

http://www.rohm.com/web/global/products/-/product/BD28623MUV

---

Changes in v2:
  - Change gpio properties to optional
  - Change VCCA, VCCP-supply to mandatory
  - Fix lisence comment style
  - Use _cansleep() version for manipulating GPIO
  - Use ASoC component remove() function instead of
    platform remove() function to power off this IC
  - Remove update function that was just alias of gpiod_set_value


Katsuhiro Suzuki (2):
  ASoC: add DT bindings documentation for ROHM BD28623 codec
  ASoC: support ROHM BD28623 codec

 .../devicetree/bindings/sound/rohm,bd28623.txt     |  29 +++
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/bd28623.c                         | 242 +++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
 create mode 100644 sound/soc/codecs/bd28623.c

-- 
2.16.1
