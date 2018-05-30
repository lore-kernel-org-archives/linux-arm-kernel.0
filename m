From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 May 2018 17:48:30 +0800
Subject: [xlnx:xlnx_rebase_v4.14 471/940] drivers/usb/dwc3/core.h:1242:
 multiple definition of `dwc3_set_usb_core_power'
Message-ID: <201805301728.X3GflHJz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   7a6053b3d256fa5bc23f28a9d9a23d7a2004c5b7
commit: b5ef7eccd876aba79c9f4eca712f0d4a89c50363 [471/940] dwc3: Add code for supporting entering into D3 state during suspend
config: i386-randconfig-s0-201821 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout b5ef7eccd876aba79c9f4eca712f0d4a89c50363
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_check_quirks':
   drivers/usb/dwc3/core.h:1240: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1240: first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1242: multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1242: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_wakeup_capable':
   include/linux/device.h:984: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_simple_data':
   include/linux/device.h:984: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_check_quirks':
   drivers/usb/dwc3/core.h:1240: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1240: first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1242: multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1242: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_simple_check_quirks':
   drivers/usb/dwc3/core.h:1240: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1240: first defined here
   drivers/usb/dwc3/ulpi.o: In function `dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1242: multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1242: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   drivers/usb/dwc3/core.h:1236: multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1236: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_check_quirks':
   drivers/usb/dwc3/core.h:1240: multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1240: first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1242: multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.h:1242: first defined here

vim +1242 drivers/usb/dwc3/core.h

  1222	
  1223	#if IS_ENABLED(CONFIG_USB_DWC3_OF_SIMPLE)
  1224	int dwc3_enable_hw_coherency(struct device *dev);
  1225	void dwc3_set_phydata(struct device *dev, struct phy *phy);
  1226	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup);
  1227	void dwc3_set_simple_data(struct dwc3 *dwc);
  1228	void dwc3_simple_check_quirks(struct dwc3 *dwc);
  1229	int dwc3_set_usb_core_power(struct dwc3 *dwc, bool on);
  1230	#else
  1231	static inline int dwc3_enable_hw_coherency(struct device *dev)
  1232	{ return 1; }
  1233	static inline void dwc3_set_phydata(struct device *dev, struct phy *phy)
  1234	{ ; }
  1235	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup)
> 1236	{ ; }
  1237	void dwc3_set_simple_data(struct dwc3 *dwc)
  1238	{ ; }
  1239	void dwc3_simple_check_quirks(struct dwc3 *dwc)
  1240	{ ; }
  1241	int dwc3_set_usb_core_power(struct dwc3 *dwc, bool on)
> 1242	{ ; }
  1243	#endif
  1244	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/3c0fdf9e/attachment-0001.gz>
