From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Fri, 29 May 2015 13:35:51 +0530
Subject: [PATCH 0/3] Add RS-485 support and fix RTS/CTS implementation
Message-ID: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add pinmux for UART_0 RTS/CTS pins.

- Since hardware can handle RTS/CTS flow control automatically,
  remove manual control of RTS/CTS from set/get mctrl.

- Add RS-485 support for Vybird platform.


Bhuvanchandra DV (3):
  ARM: dts: colibri-vf: Add pinmux for UART_0 aka UART_A RTS/CTS pins
  tty: serial: fsl_lpuart: remove RTS/CTS control from set/get_mctrl
  tty: serial: fsl_lpuart: Add support for RS-485

 arch/arm/boot/dts/vf-colibri.dtsi |   2 +
 drivers/tty/serial/fsl_lpuart.c   | 112 +++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 44 deletions(-)

-- 
2.1.0
