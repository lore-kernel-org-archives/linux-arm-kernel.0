From: lkp@intel.com (kbuild test robot)
Date: Fri, 11 May 2018 01:10:47 +0800
Subject: [xlnx:xlnx_rebase_v4.14 308/918] drivers/usb/dwc3/host.c:24:6:
 error: redefinition of 'dwc3_host_wakeup_capable'
Message-ID: <201805110145.xk87j5vQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   944a760cdb1098e23096c923aef70488fdbd501b
commit: c46d066e5633e178b138742850c37ed262a9af6d [308/918] dwc3: Add support for clock disabling during suspend
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c46d066e5633e178b138742850c37ed262a9af6d
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/usb/dwc3/host.c:24:6: error: redefinition of 'dwc3_host_wakeup_capable'
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/dwc3/host.c:20:0:
   include/linux/usb/xhci_pdriver.h:25:6: note: previous definition of 'dwc3_host_wakeup_capable' was here
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~

vim +/dwc3_host_wakeup_capable +24 drivers/usb/dwc3/host.c

    23	
  > 24	void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
    25	{
    26		dwc3_simple_wakeup_capable(dev, wakeup);
    27	}
    28	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49013 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/4a0c175f/attachment-0001.gz>
