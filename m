From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 19:51:29 +0800
Subject: [PATCH v2] serial: atmel: Use atmel_port consistently
In-Reply-To: <1453806246-13405-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201601261915.44rKN7M2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaeden,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Ferre/serial-atmel-Use-atmel_port-consistently/20160126-190554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/tty/serial/atmel_serial.c: In function 'atmel_serial_probe':
>> drivers/tty/serial/atmel_serial.c:2688:2: error: 'port' undeclared (first use in this function)
     port->gpios = mctrl_gpio_init(&port->uart, 0);
     ^
   drivers/tty/serial/atmel_serial.c:2688:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/port +2688 drivers/tty/serial/atmel_serial.c

f1d867e0 drivers/tty/serial/atmel_serial.c Jaeden Amero     2016-01-26  2682  	spin_lock_init(&atmel_port->lock_suspended);
2c7af5ba drivers/tty/serial/atmel_serial.c Boris BREZILLON  2015-03-02  2683  
f1d867e0 drivers/tty/serial/atmel_serial.c Jaeden Amero     2016-01-26  2684  	ret = atmel_init_port(atmel_port, pdev);
91f8c2d8 drivers/tty/serial/atmel_serial.c Boris BREZILLON  2013-06-19  2685  	if (ret)
6fbb9bdf drivers/tty/serial/atmel_serial.c Cyrille Pitchen  2014-12-09  2686  		goto err_clear_bit;
afefc415 drivers/serial/at91_serial.c      Andrew Victor    2006-06-19  2687  
18dfef9c drivers/tty/serial/atmel_serial.c Uwe Kleine-K?nig 2015-10-18 @2688  	port->gpios = mctrl_gpio_init(&port->uart, 0);
18dfef9c drivers/tty/serial/atmel_serial.c Uwe Kleine-K?nig 2015-10-18  2689  	if (IS_ERR(port->gpios)) {
18dfef9c drivers/tty/serial/atmel_serial.c Uwe Kleine-K?nig 2015-10-18  2690  		ret = PTR_ERR(port->gpios);
18dfef9c drivers/tty/serial/atmel_serial.c Uwe Kleine-K?nig 2015-10-18  2691  		goto err_clear_bit;

:::::: The code at line 2688 was first introduced by commit
:::::: 18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d serial: atmel: convert to irq handling provided mctrl-gpio

:::::: TO: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44066 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/acf9cafa/attachment-0001.obj>
