From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 21 Jul 2014 11:42:02 +0200
Subject: [PATCH 0/2] use correct type for dma_map/unmap
Message-ID: <1405935725-10457-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently stumbled over the fact that the Atmel I2C driver used a wrong enum
for mapping dma, so I wrote a hackish coccinelle script to check the rest of the
kernel. Luckily, only those two were found.

Wolfram Sang (2):
  drivers/i2c/busses: use correct type for dma_map/unmap
  drivers/tty/serial: use correct type for dma_map/unmap

 drivers/i2c/busses/i2c-at91.c     | 4 ++--
 drivers/tty/serial/atmel_serial.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.0.0
