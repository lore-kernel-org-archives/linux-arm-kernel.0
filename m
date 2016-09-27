From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 27 Sep 2016 16:13:10 +0200
Subject: [PATCHv3 0/3] Fix hardware handshake on SAM9x5 platforms
Message-ID: <20160927141313.27668-1-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1cf6e8fc8341 ("tty/serial: at91: fix RTS line management when
hardware handshake is enabled"), hardware handshake is not working
anymore on SAM9x5/SAMA5D3/SAM9 platforms.

The first two patches fix the hardware handshake when CTS/RTS pins are
handled by GPIOs.

The last patch fixes hardware handshake when CTS/RTS pins are not GPIOs.

Changes since v2:
 - remove IS_ERR_OR_NULL() test in patch 1/3 as Uwe suggested.
 - fix typos in patch 2/3
 - rebase on next-20160927
 - simplify the logic in patch 3/3.

Changes since v1:
 - Correct patch 1 with the error found by kbuild.
 - Add Alexandre's Acked-by on patch 2
 - Rewrite patch 3 logic in the light of the on-going discussion
   with Cyrille and Alexandre.

NB: patch 2 NEEDS patch 1 to compile.

Richard Genoud (3):
  serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
  tty/serial: at91: fix hardware handshake with GPIOs
  tty/serial: at91: fix hardware handshake on SAM9x5 (without GPIOs)

 drivers/tty/serial/atmel_serial.c      | 26 +++++++++++++++++---------
 drivers/tty/serial/serial_mctrl_gpio.c |  8 ++++++++
 drivers/tty/serial/serial_mctrl_gpio.h | 10 ++++++++++
 3 files changed, 35 insertions(+), 9 deletions(-)
