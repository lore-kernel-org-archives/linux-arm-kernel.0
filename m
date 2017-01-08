From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 Jan 2017 22:31:14 +0100
Subject: [PATCH 0/3] pinctrl: sunxi: Support variants
Message-ID: <cover.53580d3fc31eec98682d3d81f17be89610d397ee.1483911013.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie aims at bringing in a mechanism that allow to support both
multiple SoCs based on the same pin and functions table, and to restrict
those pins and functions only to a subset of the SoCs supported.

As the diffstat shows, it allows to reduce greatly the number of lines of
code (and hence the size of the kernel image) by reducing the duplication
on family of the similar SoCs.

Let me know what you think,
Maxime

Maxime Ripard (3):
  pinctrl: sunxi: Add pinctrl variants
  pinctrl: sunxi: Add common sun5i pinctrl driver
  pinctrl: sunxi: Remove old sun5i pinctrl drivers

 drivers/pinctrl/sunxi/Kconfig              |  10 +-
 drivers/pinctrl/sunxi/Makefile             |   4 +-
 drivers/pinctrl/sunxi/pinctrl-gr8.c        | 536 +----------------
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c | 685 +--------------------
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c  | 403 +------------
 drivers/pinctrl/sunxi/pinctrl-sun5i.c      | 756 ++++++++++++++++++++++-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c      |  77 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h      |  30 +-
 8 files changed, 843 insertions(+), 1658 deletions(-)
 delete mode 100644 drivers/pinctrl/sunxi/pinctrl-gr8.c
 delete mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
 delete mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i.c

base-commit: 7ce7d89f48834cefece7804d38fc5d85382edf77
-- 
git-series 0.8.11
