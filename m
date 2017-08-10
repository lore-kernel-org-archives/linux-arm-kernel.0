From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Aug 2017 22:27:20 +0800
Subject: [xlnx:master 866/880] drivers/pinctrl/pinctrl-zynqmp.c:1645:
 undefined reference to `zynqmp_pm_mmio_write'
Message-ID: <201708102212.TcXdsUsB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e51604bf16d3aaf13ace953eb434359ba9247a91
commit: 03072221332381377af031308cf840a7e69db17e [866/880] soc: zynqmp: Extract firmware part from PM
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 03072221332381377af031308cf840a7e69db17e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `zynqmp_pctrl_writereg':
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
   drivers/pinctrl/pinctrl-zynqmp.c:1645:(.text+0x206d8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_write'
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
   drivers/pinctrl/pinctrl-zynqmp.c:1645:(.text+0x20754): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pctrl_readreg':
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20854): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x208b4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20934): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20994): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x209ec): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/built-in.o:drivers/pinctrl/pinctrl-zynqmp.c:1650: more undefined references to `zynqmp_pm_mmio_read' follow
   drivers/built-in.o: In function `zynqmp_pctrl_readreg':
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20a84): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/pinctrl/pinctrl-zynqmp.c:1650:(.text+0x20adc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `zynqmp_pctrl_writereg':
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
   drivers/pinctrl/pinctrl-zynqmp.c:1645:(.text+0x20c94): additional relocation overflows omitted from the output
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pctrl_readreg':
>> drivers/pinctrl/pinctrl-zynqmp.c:1650: undefined reference to `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `zynqmp_pctrl_writereg':
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
>> drivers/pinctrl/pinctrl-zynqmp.c:1645: undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pm_request_suspend':
>> drivers/soc/xilinx/zynqmp/pm.c:135: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_force_powerdown':
   drivers/soc/xilinx/zynqmp/pm.c:151: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_request_wakeup':
   drivers/soc/xilinx/zynqmp/pm.c:170: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_set_wakeup_source':
   drivers/soc/xilinx/zynqmp/pm.c:188: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_system_shutdown':
   drivers/soc/xilinx/zynqmp/pm.c:202: undefined reference to `invoke_pm_fn'
   drivers/built-in.o:drivers/soc/xilinx/zynqmp/pm.c:222: more undefined references to `invoke_pm_fn' follow
   drivers/built-in.o: In function `zynqmp_pm_get_node_status':
>> drivers/soc/xilinx/zynqmp/pm.c:323: undefined reference to `zynqmp_pm_ret_code'
   drivers/built-in.o: In function `zynqmp_pm_get_operating_characteristic':
   drivers/soc/xilinx/zynqmp/pm.c:345: undefined reference to `invoke_pm_fn'
   drivers/soc/xilinx/zynqmp/pm.c:350: undefined reference to `zynqmp_pm_ret_code'
   drivers/built-in.o: In function `pggs_store':
>> drivers/soc/xilinx/zynqmp/pm.c:1076: undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `ggs_store':
   drivers/soc/xilinx/zynqmp/pm.c:922: undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pm_get_callback_data':
   drivers/soc/xilinx/zynqmp/pm.c:358: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `suspend_mode_store':
   drivers/soc/xilinx/zynqmp/pm.c:794: undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_probe':
>> drivers/soc/xilinx/zynqmp/pm.c:1145: undefined reference to `zynqmp_pm_get_api_version'
   drivers/built-in.o: In function `pggs_show':
>> drivers/soc/xilinx/zynqmp/pm.c:996: undefined reference to `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `ggs_show':
   drivers/soc/xilinx/zynqmp/pm.c:838: undefined reference to `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `zynqmp_pm_init_finalize':
   drivers/soc/xilinx/zynqmp/pm.c:1232: undefined reference to `invoke_pm_fn'

vim +1645 drivers/pinctrl/pinctrl-zynqmp.c

a95257bc Chirag Parekh 2017-01-27  1641  
a95257bc Chirag Parekh 2017-01-27  1642  /* Write/Read access to Registers */
a95257bc Chirag Parekh 2017-01-27  1643  static inline int zynqmp_pctrl_writereg(u32 val, u32 reg, u32 mask)
a95257bc Chirag Parekh 2017-01-27  1644  {
a95257bc Chirag Parekh 2017-01-27 @1645  	return zynqmp_pm_mmio_write(reg, mask, val);
a95257bc Chirag Parekh 2017-01-27  1646  }
a95257bc Chirag Parekh 2017-01-27  1647  
a95257bc Chirag Parekh 2017-01-27  1648  static inline int zynqmp_pctrl_readreg(u32 *val, u32 reg)
a95257bc Chirag Parekh 2017-01-27  1649  {
a95257bc Chirag Parekh 2017-01-27 @1650  	return zynqmp_pm_mmio_read(reg, val);
a95257bc Chirag Parekh 2017-01-27  1651  }
a95257bc Chirag Parekh 2017-01-27  1652  

:::::: The code at line 1645 was first introduced by commit
:::::: a95257bc7cd474a92b756452571550997a93b962 pinctrl: zynqmp: Add pin controller driver

:::::: TO: Chirag Parekh <chirag.parekh@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32076 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/a327b6fd/attachment-0001.gz>
