From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu,  3 Aug 2017 13:40:31 +0200
Subject: [PATCH RFC 0/2] spi: pxa2xx: gpiod cleanups and late CS GPIO
 allocation
Message-ID: <cover.1501760433.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up to the discussion on
https://lkml.org/lkml/2017/7/8/42. It tries to convert more of pxa2xx
driver to gpio descriptors, and it does that late CS GPIO binding, but
now hopefully without violating the GPIO API and while taking multiple
calls to setup_cs into account.

Jan

Jan Kiszka (2):
  spi: pxa2xx: Convert to GPIO descriptor API where possible
  spi: pxa2xx: Only claim CS GPIOs when the slave device is created

 drivers/spi/spi-pxa2xx.c | 92 ++++++++++++++++++++++--------------------------
 drivers/spi/spi-pxa2xx.h |  5 ++-
 2 files changed, 44 insertions(+), 53 deletions(-)

-- 
2.12.3
