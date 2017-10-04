From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 4 Oct 2017 21:19:15 +0800
Subject: [xlnx:master 823/1043] drivers/usb//dwc3/host.c:24:6: error:
 redefinition of 'dwc3_host_wakeup_capable'
Message-ID: <201710042113.Ej59BcG6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anurag,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f1b1e077d641fc83b54c1b8f168cbb58044fbd4e
commit: 80ac0da9010ebabef6ed1d66b6607b345fd14cb4 [823/1043] dwc3: Add support for clock disabling during suspend
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 80ac0da9010ebabef6ed1d66b6607b345fd14cb4
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/usb//dwc3/host.c:24:6: error: redefinition of 'dwc3_host_wakeup_capable'
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb//dwc3/host.c:20:0:
   include/linux/usb/xhci_pdriver.h:25:6: note: previous definition of 'dwc3_host_wakeup_capable' was here
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~

vim +/dwc3_host_wakeup_capable +24 drivers/usb//dwc3/host.c

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
Size: 45285 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/d660c2fb/attachment-0001.gz>
