From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 14:13:18 +0200
Subject: [PATCH 0/5] serial: Add Generic Serial Device Tree Bindings
Message-ID: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series, against next-20160414, introduces Generic Serial
Device Tree Bindings, and converts drivers using vendor-specific DT
properties to the generic properies where appropriate.

The Generic Serial Device Tree Bindings document a set of generic
properties for describing UARTs in a device tree:
  1. The GPIO modem control properties are currently duplicated across
     hardware-specific binding documentation,
  2. The property for dedicated RTS/CTS hardware flow control lines is
     already supported by several drivers, albeit with a vendor-specific
     prefix, hence make it generic.
Whether these generic properties apply to a particular device still
depends on the DT bindings of the actual device.

The old (deprecated) vendor-specific properties are still supported by
the drivers for backwards compatibility.  Actual DTS files are to be
updated later, after this series has been integrated into mainline.

Thanks for your comments!

Geert Uytterhoeven (5):
  doc: DT: Add Generic Serial Device Tree Bindings
  serial: imx: Use generic uart-has-rtscts DT property
  serial: mxs-auart: Use generic uart-has-rtscts DT property
  serial: sirf: Introduce helper variable struct device_node *np
  serial: sirf: Use generic uart-has-rtscts DT property

 .../devicetree/bindings/serial/fsl-imx-uart.txt    |  4 +-
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |  2 +-
 .../devicetree/bindings/serial/serial.txt          | 61 ++++++++++++++++++++++
 .../devicetree/bindings/serial/sirf-uart.txt       |  8 +--
 drivers/tty/serial/imx.c                           |  3 +-
 drivers/tty/serial/mxs-auart.c                     |  3 +-
 drivers/tty/serial/sirfsoc_uart.c                  | 39 +++++++-------
 7 files changed, 91 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/serial.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
