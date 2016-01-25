From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 02:34:07 +0800
Subject: [PATCH 2/2] serial: atmel: add support for new UART version
In-Reply-To: <93f5f783fd232d9dfe99e7d6f1fdc6c92adb7c46.1453743308.git.nicolas.ferre@atmel.com>
Message-ID: <201601260224.Djb6afTp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Ferre/serial-atmel-trivial-clean-the-IP-version-decoding-code/20160126-014116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/tty/serial/atmel_serial.c: In function 'atmel_get_ip_name':
>> drivers/tty/serial/atmel_serial.c:1717:2: error: 'new_uart' undeclared (first use in this function)
     new_uart = 0x55415254; /* UART */
     ^
   drivers/tty/serial/atmel_serial.c:1717:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/new_uart +1717 drivers/tty/serial/atmel_serial.c

  1711		int name = atmel_uart_readl(port, ATMEL_US_NAME);
  1712		u32 version;
  1713		u32 usart, dbgu_uart;
  1714		/* ASCII decoding for IP version */
  1715		usart = 0x55534152;	/* USAR(T) */
  1716		dbgu_uart = 0x44424755;	/* DBGU */
> 1717		new_uart = 0x55415254;	/* UART */
  1718	
  1719		atmel_port->has_hw_timer = false;
  1720	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53452 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/041abed5/attachment-0001.obj>
