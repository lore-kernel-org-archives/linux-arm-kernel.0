From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Oct 2017 04:10:28 +0800
Subject: [xlnx:master 1048/1054] drivers/usb/dwc3/core.h:1192:1: warning:
 control reaches end of non-void function
Message-ID: <201710180426.R15FyPFV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e82bfab8e7e6978a3009461f661964f45712bfdb
commit: 4e93ddc6c0fad23387c55e185019e5091fb0b5ad [1048/1054] dwc3: Add code for supporting entering into D3 state during suspend
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4e93ddc6c0fad23387c55e185019e5091fb0b5ad
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/dwc3/ulpi.c:15:0:
   drivers/usb/dwc3/core.h: In function 'dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1192:1: warning: control reaches end of non-void function [-Wreturn-type]
    { ; }
    ^
--
   drivers/usb/dwc3/host.c:24:6: error: redefinition of 'dwc3_host_wakeup_capable'
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/dwc3/host.c:20:0:
   include/linux/usb/xhci_pdriver.h:25:6: note: previous definition of 'dwc3_host_wakeup_capable' was here
    void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/dwc3/host.c:22:0:
   drivers/usb/dwc3/core.h: In function 'dwc3_set_usb_core_power':
>> drivers/usb/dwc3/core.h:1192:1: warning: control reaches end of non-void function [-Wreturn-type]
    { ; }
    ^

vim +1192 drivers/usb/dwc3/core.h

  1172	
  1173	#if IS_ENABLED(CONFIG_USB_DWC3_OF_SIMPLE)
  1174	int dwc3_enable_hw_coherency(struct device *dev);
  1175	void dwc3_set_phydata(struct device *dev, struct phy *phy);
  1176	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup);
  1177	void dwc3_set_simple_data(struct dwc3 *dwc);
  1178	void dwc3_simple_check_quirks(struct dwc3 *dwc);
  1179	int dwc3_set_usb_core_power(struct dwc3 *dwc, bool on);
  1180	#else
  1181	static inline int dwc3_enable_hw_coherency(struct device *dev)
  1182	{ return 1; }
  1183	static inline void dwc3_set_phydata(struct device *dev, struct phy *phy)
  1184	{ ; }
  1185	void dwc3_simple_wakeup_capable(struct device *dev, bool wakeup)
  1186	{ ; }
  1187	void dwc3_set_simple_data(struct dwc3 *dwc)
  1188	{ ; }
  1189	void dwc3_simple_check_quirks(struct dwc3 *dwc)
  1190	{ ; }
  1191	int dwc3_set_usb_core_power(struct dwc3 *dwc, bool on)
> 1192	{ ; }
  1193	#endif
  1194	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42496 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/0a7b9575/attachment-0001.gz>
