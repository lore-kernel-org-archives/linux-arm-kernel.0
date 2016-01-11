From: lkp@intel.com (kbuild test robot)
Date: Mon, 11 Jan 2016 18:04:27 +0800
Subject: [PATCH 1/1] USB: core: let USB device know device node
In-Reply-To: <1452501535-8580-1-git-send-email-peter.chen@freescale.com>
Message-ID: <201601111855.RTgXWRmJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on v4.4 next-20160108]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Chen/USB-core-let-USB-device-know-device-node/20160111-164533
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> include/linux/usb.h:621: warning: No description found for parameter 'of_node'

vim +/of_node +621 include/linux/usb.h

151230068 Sarah Sharp          2007-12-21  605  
645daaab0 Alan Stern           2006-08-30  606  #ifdef CONFIG_PM
f476fbaba Randy Dunlap         2008-02-13  607  	unsigned long connect_time;
f476fbaba Randy Dunlap         2008-02-13  608  
f476fbaba Randy Dunlap         2008-02-13  609  	unsigned do_remote_wakeup:1;
f476fbaba Randy Dunlap         2008-02-13  610  	unsigned reset_resume:1;
bfd1e9101 Alan Stern           2012-10-19  611  	unsigned port_is_suspended:1;
645daaab0 Alan Stern           2006-08-30  612  #endif
b1d8dfb0e Inaky Perez-Gonzalez 2008-04-08  613  	struct wusb_dev *wusb_dev;
c6515272b Sarah Sharp          2009-04-27  614  	int slot_id;
0846e7e98 Matthew Garrett      2012-02-03  615  	enum usb_device_removable removable;
17f34867e Mathias Nyman        2013-05-23  616  	struct usb2_lpm_parameters l1_params;
51e0a0120 Sarah Sharp          2012-02-20  617  	struct usb3_lpm_parameters u1_params;
51e0a0120 Sarah Sharp          2012-02-20  618  	struct usb3_lpm_parameters u2_params;
1ea7e0e8e Sarah Sharp          2012-04-24  619  	unsigned lpm_disable_count;
9d9d6644d Peter Chen           2016-01-11  620  	struct device_node	*of_node; /* associated device tree node */
^1da177e4 Linus Torvalds       2005-04-16 @621  };
^1da177e4 Linus Torvalds       2005-04-16  622  #define	to_usb_device(d) container_of(d, struct usb_device, dev)
^1da177e4 Linus Torvalds       2005-04-16  623  
1e429018b Matthew Wilcox       2010-04-30  624  static inline struct usb_device *interface_to_usbdev(struct usb_interface *intf)
1e429018b Matthew Wilcox       2010-04-30  625  {
1e429018b Matthew Wilcox       2010-04-30  626  	return to_usb_device(intf->dev.parent);
1e429018b Matthew Wilcox       2010-04-30  627  }
1e429018b Matthew Wilcox       2010-04-30  628  
^1da177e4 Linus Torvalds       2005-04-16  629  extern struct usb_device *usb_get_dev(struct usb_device *dev);

:::::: The code at line 621 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6133 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160111/e1bd9b08/attachment.obj>
