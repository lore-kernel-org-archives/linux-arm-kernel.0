From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:09:59 +0800
Subject: [PATCH 00/16] Unify MediaTek pinctrl in preparation for MT8183 and
 MT6765
Message-ID: <cover.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Irregular register arrangement and their logic access from various MediaTek
SoCs being introduced already causes pinctrl-mtk-common to bloat and became
really hard to maintain so that the patch creates pinctrl-mtk-common-v2 based
on the core of mt7622 pinctrl to try make the register operations to be simple.

The goals pinctrl-mtk-common-v2 want to achieve are to hopefully support
all of MediaTek SoCs, and two kinds of dt-bindings being supported,
Linux generic pinctrl dt-binding which mt762x like to support and MediaTek
vendor per-pin dt-binding the other SoCs support the MT8183 and MT6765 incline
to make use of.

The patch starts to refactor MT7622 pinctrl driver first with splitting
out these portable ways from there such as table-based register operation
and the other operations in common in the both kinds of driver.

Sean Wang (16):
  pinctrl: mediatek: add pinctrl-mtk-common-v2 for all MediaTek pinctrls
  pinctrl: mediatek: add pinctrl-moore that implements the generic
    pinctrl dt-bindings
  pinctrl: mediatek: extend struct mtk_pin_field_calc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: extend struct mtk_pin_desc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: extend struct mtk_pin_soc to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add driving strength related support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add drv register support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add pull related support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add advanced pull related support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add ies register support to pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add pullen, pullsel register support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add MT7623 pinctrl driver based on generic pinctrl
    binding
  pinctrl: mediatek: use pin descriptor all in pinctrl-mtk-common-v2.c
  pinctrl: mediatek: add multiple register bases support to
    pinctrl-mtk-common-v2.c
  pinctrl: mediatek: adjust error code and message when some register
    not supported is found
  pinctrl: mediatek: extend struct mtk_pin_desc which per-pin driver
    depends on

 drivers/pinctrl/mediatek/Kconfig                 |   25 +-
 drivers/pinctrl/mediatek/Makefile                |    2 +
 drivers/pinctrl/mediatek/pinctrl-moore.c         |  813 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-moore.h         |   57 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 1407 ++++-----------------
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        | 1441 ++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  510 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  281 +++++
 8 files changed, 3345 insertions(+), 1191 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7623.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h

-- 
2.7.4
