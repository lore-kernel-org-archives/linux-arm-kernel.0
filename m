From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 15 Jan 2013 17:58:02 +1300
Subject: [GIT PULL v2] Fixes/cleanup for vt8500 serial driver
Message-ID: <1358225886-5686-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This is a series of fixes/cleanup for the vt8500 serial/uart driver.

I'm not sure how you want to handle these.

Arguably #1, #2 and #3 are bug fixes which could go into 3.8. None of
them cause immediate problems, but potentially could.

#4 is definately a cleanup for 3.9.

Let me know if you would rather I split them up and how.

Regards
Tony P

v2 Changes:
Restore the setting of vt8500_port->uart.uartclk which was dropped in v1.
Corrected the return-on-fail of devm_request_and_ioremap to -EADDRNOTAVAIL.


The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git tags/vt8500-serial-fixes

for you to fetch changes up to 08bab1720e19e4f980e9e93536add4a7e497b38e:

  serial: tty: Cleanup code using devm_ function (2013-01-15 17:36:50 +1300)

----------------------------------------------------------------
Series of fixes/cleanups for vt8500 serial/UART driver

----------------------------------------------------------------
Tony Prisk (4):
      serial: vt8500: Fix range-checking on vt8500_uart_ports
      serial: vt8500: ioremap'd resource is never freed
      serial: vt8500: UART uses gated clock rather than 24Mhz reference
      serial: tty: Cleanup code using devm_ function

 arch/arm/boot/dts/vt8500.dtsi      |   40 +++++++++++++++++++++---
 arch/arm/boot/dts/wm8505.dtsi      |   60 ++++++++++++++++++++++++++++++++----
 arch/arm/boot/dts/wm8650.dtsi      |   20 ++++++++++--
 drivers/tty/serial/vt8500_serial.c |   45 +++++++++++++--------------
 4 files changed, 130 insertions(+), 35 deletions(-)
