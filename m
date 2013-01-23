From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Jan 2013 10:34:05 +0100
Subject: [PATCHv2] Add GPIO driver for Allwinner SoCs
Message-ID: <1358933646-12681-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds support for the GPIOs for the Allwinner SoCs supported so
far.

It comes on top of my previous pinctrl patchset, and has been tested on a
A13-Olinuxino from Olimex.

Thanks,
Maxime

Changes from v1:
  - Merged the gpio driver with the pinctrl one
  - Now using gpiochip_add_pin_range instead of pinctrl_add_gpio_range
  - Removed the hairy range registration function, and register 1pin ranges
    instead

Maxime Ripard (1):
  ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers

 drivers/pinctrl/pinctrl-sunxi.c |  138 ++++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-sunxi.h |   23 ++++++-
 2 files changed, 158 insertions(+), 3 deletions(-)

-- 
1.7.10.4
