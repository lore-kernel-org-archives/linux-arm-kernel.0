From: frans.klaver@xsens.com (Frans Klaver)
Date: Tue, 19 Aug 2014 14:14:44 +0200
Subject: [RFC PATCHv2 0/4] omap-serial high-speed fixes/improvements
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Message-ID: <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's version 2 of the patches that should improve the behavior of the omap
serial port at high baud and data rates.

Differences with regard to v1 are:
  - centralize baud_is_mode16's calculation
  - fix/unbreak an uninitialized variable in "use threaded interrupt handler"
  - read has-hw-flow-control property in of_get_uart_port_info

Frans Klaver (4):
  tty: omap-serial: pull out calculation from baud_is_mode16
  tty: omap-serial: prevent division by zero
  tty: omap-serial: use threaded interrupt handler
  tty: omap-serial: support setting of hardware flow control in dts

 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 drivers/tty/serial/omap-serial.c                   | 65 +++++++++++++++++-----
 2 files changed, 51 insertions(+), 15 deletions(-)

-- 
1.9.3
