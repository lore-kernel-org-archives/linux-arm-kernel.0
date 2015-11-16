From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 17:39:35 +0000
Subject: [PATCH 00/12] Prepare amba-pl011 for ZTE UART support
Message-ID: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a re-posting of the updates to the AMBA PL011 primecell
serial port.

ZTE UARTs differ from the ARM version in two ways: the address layout
of the register set is substantially different, and the register access
size needs to be 32-bit.

This series converts the driver to use a lookup table to address the
first point, and switches to use a flag to indicate the access size.
We also switch the driver to use relaxed accessors, which is safe as
none of these are responsible for DMA configuration.

 drivers/tty/serial/amba-pl011.c | 335 ++++++++++++++++++++++++++--------------
 drivers/tty/serial/amba-pl011.h |  34 ++++
 include/linux/amba/serial.h     |  18 +++
 3 files changed, 269 insertions(+), 118 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
