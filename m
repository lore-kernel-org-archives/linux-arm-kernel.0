From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 14 Jan 2015 11:08:06 +0100
Subject: [PATCH v2 0/3] pinctrl: at91: allow disabled gpio controllers
Message-ID: <1421230089-1418-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have updated the previous version. I have tried to follow your advice but it
doesn't seem to be the best solution in my case.

You told me to use gpiochip_add_pingroup_range() instead of
pinctrl_add_gpio_range(). I agree that is the proper way to manage a gap but it
only solves my issue on gpio side but not on muxing side. I still need some
fixes. Moreover it involves to add the gpio-ranges property so to update our
dtsi files so it will break backward compatibility.

By the way, I would like to be co-maintainer on this driver as it seems the
maintainer is not very active at the moment.

Regards

Ludovic

Ludovic Desroches (3):
  pinctrl: at91: allow disabled pio controllers
  ARM: at91/dt: sama5d4: add pioD controller
  MAINTAINERS: add maintainer for pinctrl-at91

 MAINTAINERS                    |  1 +
 arch/arm/boot/dts/sama5d4.dtsi | 13 +++++++++++++
 drivers/pinctrl/pinctrl-at91.c | 30 ++++++++++++++++++++++--------
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.2.0
