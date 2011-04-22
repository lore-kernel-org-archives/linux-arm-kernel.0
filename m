From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:41:06 +0530
Subject: [PATCH v4 0/1] pruss CAN driver.
Message-ID: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a SocketCAN complaint CAN Network driver implemented on
the Programmable Real Time Unit (PRUSS) available on da8xx
processors from Texas Instruments.

It utilizes both available PRUs on da8xx for concurrent Rx/Tx processing
and load sharing. PRU0 is used as Rx and PRU1 as Tx.

This controller also supports ID filtering at the device level.
Eight different ID can be programmed into the device through
the sysfs interface exported by the driver.

version 4:
=========
* added NAPI
* added sysfs entry for programming mailbox IDs
* added bittiming interface from the kernel
* removed unused function
* improved coding style
* removed unwanted files
* merged required files into the driver
* code cleanup as per review comments

NOTE:	The versioning is being maintained in sequence with the complete set
	of patches submitted for the PRUSS.

Subhasish Ghosh (1):
  can: add pruss CAN driver.

 drivers/net/can/Kconfig     |    7 +
 drivers/net/can/Makefile    |    1 +
 drivers/net/can/pruss_can.c | 1074 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1082 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/pruss_can.c

-- 
1.7.2.3
