From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 23 Jan 2015 21:01:04 +0800
Subject: [PATCH v7 0/2] Add Spreadtrum SoC bindings and serial driver support
In-Reply-To: <sprd-serial-v7>
References: <sprd-serial-v7>
Message-ID: <1422018066-24997-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set split the last version, and addressed the review comments from
last version on serial driver code.

Changes from v6:
	- Setted SPRD_TIMEOUT with 256 rather than 2048
	- Used u32 instead of uint32_t
	- Removed inline of handle_lsr_errors which is a single call site function
	- Removed unused parameter of sprd_tx & sprd_rx
	- Used spin_lock_irqsave in sprd_startup() instead of spin_lock
	- Added a check for port->sysrq in sprd_console_write()
	- Used a global counter as a condition of calling uart_{un}register_driver
	- Added pdev->id assignment in probe()
	- Setted port->flags with UPF_BOOT_AUTOCONF instead of ASYNC_BOOT_AUTOCONF

Changes from v5:
	- Used Spreadtrum instead of SPRD in menus
	- Changed TTY name to 'ttyS'
	- Moved uart_register_driver() to probe()
	- Added spinlock as needed
	- Removed register states saving and restoring in suspend() and resume()

Chunyan Zhang (2):
  Documentation: DT: Add bindings for Spreadtrum SoC Platform
  tty/serial: Add Spreadtrum sc9836-uart driver support

 Documentation/devicetree/bindings/arm/sprd.txt     |   11 +
 .../devicetree/bindings/serial/sprd-uart.txt       |    7 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/tty/serial/Kconfig                         |   18 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sprd_serial.c                   |  799 ++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |    3 +
 7 files changed, 840 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 create mode 100644 drivers/tty/serial/sprd_serial.c

-- 
1.7.9.5
