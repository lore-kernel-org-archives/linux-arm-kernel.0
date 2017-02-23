From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 23 Feb 2017 10:38:38 +0200
Subject: [PATCH 0/2] drivers: pwm: add pwm support for sama5d2
Message-ID: <1487839120-13650-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend atmel-pwm driver in order to support sama5d2 pwm
specifics. Since the new SoC supports changing of pwm
parameters (period and duty factor) without need to first
disable/enable the pwm channel this series adapt the
existing code in order to let changing of these parameters
for sama5d2.

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: add support for pwm on sama5d2
  drivers: pwm: pwm-atmel: add support to allow run time changing of
    pwm parameters

 .../devicetree/bindings/pwm/atmel-pwm.txt          |  1 +
 drivers/pwm/pwm-atmel.c                            | 40 ++++++++++++++++++----
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.7.4
