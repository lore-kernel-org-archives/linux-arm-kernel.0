From: frans.klaver@xsens.com (Frans Klaver)
Date: Mon, 15 Sep 2014 16:00:06 +0200
Subject: [PATCH v3 0/4] omap-serial high-speed fixes/improvements
Message-ID: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here's version 3 of my fixes for high speed usage of the omap serial driver.
Sebastian's 8250 based implementation doesn't seem to be quite there yet. As
long as that's the case, I'd like to go ahead with improving this series.

v2..v3
  - fix an undefined variable in "prevent division by zero"
  - use IRQ_ONESHOT for the threaded irq in "use threaded interrupt handler"

v1..v2
  - centralize baud_is_mode16's calculation
  - fix/unbreak an uninitialized variable in "use threaded interrupt handler"
  - read has-hw-flow-control property in of_get_uart_port_info

Frans Klaver (4):
  tty: omap-serial: pull out calculation from baud_is_mode16
  tty: omap-serial: prevent division by zero
  tty: omap-serial: use threaded interrupt handler
  tty: omap-serial: support setting of hardware flow control in dts

 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 drivers/tty/serial/omap-serial.c                   | 64 +++++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

-- 
2.1.0
