From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Nov 2017 23:58:20 +0800
Subject: [xlnx:master 866/1093] debugfs.c:undefined reference to
 `zynqmp_pm_mmio_write'
Message-ID: <201711072316.aUk0zxOs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   bd8f87ca6a415c7d90615ddaa683bdbf781114bc
commit: 03072221332381377af031308cf840a7e69db17e [866/1093] soc: zynqmp: Extract firmware part from PM
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 03072221332381377af031308cf840a7e69db17e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `zynqmp_pinmux_set_mux':
>> debugfs.c:(.text+0x206d8): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x206d8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pinmux_free_pin':
   debugfs.c:(.text+0x20754): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x20754): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pinconf_cfg_get':
>> debugfs.c:(.text+0x20854): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20854): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x208b4): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x208b4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20934): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20934): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20994): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20994): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x209ec): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x209ec): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/built-in.o:debugfs.c:(.text+0x20a4c): more undefined references to `zynqmp_pm_mmio_read' follow
   drivers/built-in.o: In function `zynqmp_pinconf_cfg_get':
   debugfs.c:(.text+0x20a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20a84): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20adc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `zynqmp_pinconf_cfg_set':
   debugfs.c:(.text+0x20c94): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x20c94): additional relocation overflows omitted from the output
   debugfs.c:(.text+0x20d04): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x20d30): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x20dc8): undefined reference to `zynqmp_pm_mmio_read'
   debugfs.c:(.text+0x20e54): undefined reference to `zynqmp_pm_mmio_write'
   debugfs.c:(.text+0x20eb0): undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pm_request_suspend':
>> debugfs.c:(.text+0xf4d78): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_force_powerdown':
   debugfs.c:(.text+0xf4da8): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_request_wakeup':
   debugfs.c:(.text+0xf4de0): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_set_wakeup_source':
   debugfs.c:(.text+0xf4e10): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_system_shutdown':
   debugfs.c:(.text+0xf4e40): undefined reference to `invoke_pm_fn'
   drivers/built-in.o:debugfs.c:(.text+0xf4e70): more undefined references to `invoke_pm_fn' follow
   drivers/built-in.o: In function `zynqmp_pm_get_node_status':
>> debugfs.c:(.text+0xf4fa4): undefined reference to `zynqmp_pm_ret_code'
   drivers/built-in.o: In function `zynqmp_pm_get_operating_characteristic':
   debugfs.c:(.text+0xf4fec): undefined reference to `invoke_pm_fn'
   debugfs.c:(.text+0xf5000): undefined reference to `zynqmp_pm_ret_code'
   drivers/built-in.o: In function `pggs_store':
   debugfs.c:(.text+0xf5104): undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `ggs_store':
   debugfs.c:(.text+0xf528c): undefined reference to `zynqmp_pm_mmio_write'
   drivers/built-in.o: In function `zynqmp_pm_isr':
   debugfs.c:(.text+0xf5410): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `suspend_mode_store':
   debugfs.c:(.text+0xf54f4): undefined reference to `invoke_pm_fn'
   drivers/built-in.o: In function `zynqmp_pm_probe':
>> debugfs.c:(.text+0xf554c): undefined reference to `zynqmp_pm_get_api_version'
   drivers/built-in.o: In function `pggs_show.isra.1':
   debugfs.c:(.text+0xf58c0): undefined reference to `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `ggs_show.isra.3':
   debugfs.c:(.text+0xf59b8): undefined reference to `zynqmp_pm_mmio_read'
   drivers/built-in.o: In function `zynqmp_pm_init_finalize':
>> debugfs.c:(.init.text+0x16ce0): undefined reference to `invoke_pm_fn'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32050 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171107/741b81b2/attachment-0001.gz>
