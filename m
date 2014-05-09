From: dean_jenkins@mentor.com (dean_jenkins at mentor.com)
Date: Fri,  9 May 2014 16:19:43 +0100
Subject: [PATCH 0/5] serial: imx: fixes
Message-ID: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

The following set of patches were tested on an i.MX6 multi-core platform.

Patches 1 to 4 were tested using a Bluetooth BCSP UART connection at 115.2kbps
and 4Mbps. The fixes were needed because the i.MX6 UART driver caused spinlock
deadlocks with the HCI TTY layer.

Patch 5 improves the i.MX6 UART driver for use with kdb.

Patch 1: serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
Patch 2: serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
Patch 3: serial: imx: avoid spinlock recursion deadlock
Patch 4: serial: imx: move imx_transmit_buffer() into imx_txint()
Patch 5: serial: imx: clean up imx_poll_get_char()

The patches are based off 3.15-rc4.

----------------------------------------------------------------
Andy Lowe (1):
      serial: imx: avoid spinlock recursion deadlock

Dirk Behme (4):
      serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
      serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
      serial: imx: move imx_transmit_buffer() into imx_txint()
      serial: imx: clean up imx_poll_get_char()

 drivers/tty/serial/imx.c |   73 ++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)
