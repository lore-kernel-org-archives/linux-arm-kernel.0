From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 14 Sep 2012 17:43:32 +0200
Subject: [RFC PATCH] i2c: at91: add dma support
Message-ID: <1347637413-1257-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This patch provides DMA support for Atmel TWI. Only sam9x5 and sam9n12 devices
are concerned.
One part is missing since the generic device tree DMA helpers have not been
adopted yet, it has been tested with home-made ones.

It has been tested with an eeprom. Do you see potential issues with this device
or with other ones.

If you have suggestions about sg part and twi_irq_save/restore, don't hesitate.
I am not really pleased with it, I think something better could be done.

Thanks

Regards

Ludovic

Ludovic Desroches (1):
  i2c: at91: add dma support

 drivers/i2c/busses/i2c-at91.c | 323 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 311 insertions(+), 12 deletions(-)

-- 
1.7.11.3
