From: hachimi.samir@gmail.com (hachimi.samir at gmail.com)
Date: Thu, 23 Aug 2012 17:32:37 +0200
Subject: [PATCH 0/2] imx6q: pwm: Activate stop_mode and remove auto enable
 after configuration
In-Reply-To: <[PATCH 0/2] imx6q: pwm: Activate stop_mode and remove auto
 enable after configuration>
References: <[PATCH 0/2] imx6q: pwm: Activate stop_mode and remove auto enable
 after configuration>
Message-ID: <1345735959-12964-1-git-send-email-hachimi.samir@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables support for pwm driver on imx6q SoC. The first
patch of the series configure the pinctrl for pwm in device-tree. Actually
they are several pin who can be set to pwmO for each pwm, so I assume that
all of them must be enabled when configuring pin.
The second patch activate stop_enable mode and unset the enable bit during
configuration of pwm, and set the enable bit in pwm CR register during enable.

Samir Hachimi (2):
imx6q: Configure the pwm node for pinmux support.
imx6q: Set pwm control register during enable and config call
---
 arch/arm/boot/dts/imx6q.dtsi  |   50 ++++++++
 arch/arm/mach-imx/clk-imx6q.c |    4 ++++
 drivers/pwm/pwm-imx.c         |   37 ++++++++++++++++++++++++++-----------
 3 files changed, 80 insertions(+), 11 deletions(-)
