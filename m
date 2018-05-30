From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 May 2018 17:09:04 +0800
Subject: [xlnx:xlnx_rebase_v4.14 310/940] drivers/usb/dwc3/core.h:1231:
 multiple definition of `dwc3_simple_check_quirks'
Message-ID: <201805301702.XrD8jyf4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   7a6053b3d256fa5bc23f28a9d9a23d7a2004c5b7
commit: 2f495929d82aae1cbd308f22d4cf46ca2937530e [310/940] dwc3: Correct errors when dwc3 loaded as module
config: i386-randconfig-s0-201821 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 2f495929d82aae1cbd308f22d4cf46ca2937530e
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_check_quirks':
>> drivers/usb/dwc3/core.h:1231: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1231: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_wakeup_capable':
   include/linux/device.h:984: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_simple_data':
   include/linux/device.h:984: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_check_quirks':
>> drivers/usb/dwc3/core.h:1231: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1231: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_simple_check_quirks':
>> drivers/usb/dwc3/core.h:1231: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1231: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1227: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1227: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_check_quirks':
>> drivers/usb/dwc3/core.h:1231: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1231: first defined here

vim +1231 drivers/usb/dwc3/core.h

  1214	
  1215	#if IS_ENABLED(CONFIG_USB_DWC3_OF_SIMPLE)
  1216	int dwc3_enable_hw_coherency(struct device *dev);
  1217	void dwc3_set_phydata(struct device *dev, struct phy *phy);
  1218	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup);
  1219	void dwc3_set_simple_data(struct dwc3 *dwc);
  1220	void dwc3_simple_check_quirks(struct dwc3 *dwc);
  1221	#else
  1222	static inline int dwc3_enable_hw_coherency(struct device *dev)
  1223	{ return 1; }
  1224	static inline void dwc3_set_phydata(struct device *dev, struct phy *phy)
  1225	{ ; }
  1226	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup)
> 1227	{ ; }
  1228	void dwc3_set_simple_data(struct dwc3 *dwc)
  1229	{ ; }
  1230	void dwc3_simple_check_quirks(struct dwc3 *dwc)
> 1231	{ ; }
  1232	#endif
  1233	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29088 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/adc3dd95/attachment-0001.gz>
