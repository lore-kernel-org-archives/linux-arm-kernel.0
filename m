From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:06 +0900
Subject: [PATCH 00/17] pinctrl: uniphier: many clean-ups and support new
 pinctrl drivers
Message-ID: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here is a bunch of updates of UniPhier pinctrl drivers
(hopefully, for Linux 4.8-rc1).

Socionext Inc. developed two new ARMv8 SoCs this year.

New pinctrl driver support will be added by 16/17, 17/17.

But, before doing new development, it is usually nice
to clean the existing code.  So, this series also includes
several clean-up patches.

The new SoCs added some new SoC-specific features
(more fine-grained drive control, sparse pin space,
per-pin input enable gating, etc.), so I needed to update
the core support code for Uniphier pinctrl.

1/17 touches the core of pinctrl frame work, but
I included it in this series because it is a prerequisite
for 9/17.



Masahiro Yamada (17):
  pinctrl: copy per-pin driver private data to struct pin_desc
  pinctrl: uniphier: rename function and variable names
  pinctrl: uniphier: fix register offsets for drive strength control
  pinctrl: uniphier: set pinctrl_desc owner in common probe function
  pinctrl: uniphier: set pinctrl_desc name in common probe function
  pinctrl: uniphier: allocate struct pinctrl_desc in probe function
  pinctrl: uniphier: rename macros for drive strength control
  pinctrl: uniphier: support 3-bit drive strength control
  pinctrl: uniphier: support pin configuration in sparse pin space
  pinctrl: uniphier: introduce capability flag
  pinctrl: uniphier: support per-pin input enable for new SoCs
  pinctrl: uniphier: support pin configuration for dedicated pins
  pinctrl: uniphier: add dedicated pins to pin tables of PH1-LD4/sLD8
  pinctrl: uniphier: add System Bus pin-mux settings
  pinctrl: uniphier: allow to have pinctrl node under syscon node
  pinctrl: uniphier: add UniPhier PH1-LD11 pinctrl driver
  pinctrl: uniphier: add UniPhier PH1-LD20 pinctrl driver

 drivers/pinctrl/core.c                           |   22 +-
 drivers/pinctrl/core.h                           |    2 +
 drivers/pinctrl/uniphier/Kconfig                 |   20 +-
 drivers/pinctrl/uniphier/Makefile                |    2 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c |  292 +++---
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c |  956 ++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c | 1037 ++++++++++++++++++++++
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  |  480 +++++-----
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c |  595 +++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c |  787 ++++++++--------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c |  653 +++++++-------
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c |  581 ++++++------
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c |  441 +++++----
 drivers/pinctrl/uniphier/pinctrl-uniphier.h      |   59 +-
 14 files changed, 4088 insertions(+), 1839 deletions(-)
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c
 create mode 100644 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c

-- 
1.9.1
