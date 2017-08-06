From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 7 Aug 2017 05:14:35 +0800
Subject: [xlnx:2017.2_video_ea 11/28]
 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:65:19: warning: passing
 argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target
 type
Message-ID: <201708070533.kH35aIXb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.2_video_ea
head:   d9c9ef883408d0622d075cc2ca805d7d96d5b28b
commit: c33ee6950b34e8b00d9c77238dd7dfe0789dc91f [11/28] staging: xilinx: Add xilinx hdmi drivers to staging area
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout c33ee6950b34e8b00d9c77238dd7dfe0789dc91f
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:38:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:11,
                    from arch/x86/include/asm/smp.h:12,
                    from include/linux/smp.h:59,
                    from include/linux/percpu.h:6,
                    from include/linux/percpu-rwsem.h:6,
                    from include/linux/fs.h:30,
                    from include/linux/seq_file.h:10,
                    from include/linux/pinctrl/consumer.h:17,
                    from include/linux/pinctrl/devinfo.h:21,
                    from include/linux/device.h:24,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:21:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:38:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:11,
                    from arch/x86/include/asm/smp.h:12,
                    from include/linux/smp.h:59,
                    from include/linux/percpu.h:6,
                    from include/linux/percpu-rwsem.h:6,
                    from include/linux/fs.h:30,
                    from include/linux/seq_file.h:10,
                    from include/linux/pinctrl/consumer.h:17,
                    from include/linux/pinctrl/devinfo.h:21,
                    from include/linux/device.h:24,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:21:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
--
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.c:48:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
--
   In file included from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c:50:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:11,
                    from arch/x86/include/asm/smp.h:12,
                    from include/linux/smp.h:59,
                    from include/linux/percpu.h:6,
                    from include/linux/percpu-rwsem.h:6,
                    from include/linux/fs.h:30,
                    from include/linux/seq_file.h:10,
                    from include/linux/pinctrl/consumer.h:17,
                    from include/linux/pinctrl/devinfo.h:21,
                    from include/linux/device.h:24,
                    from include/linux/dma-mapping.h:6,
                    from include/drm/drmP.h:37,
                    from drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c:29:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy_hw.h:45:0,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/xvphy.h:68,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c:50:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:11,
                    from arch/x86/include/asm/smp.h:12,
                    from include/linux/smp.h:59,
                    from include/linux/percpu.h:6,
                    from include/linux/percpu-rwsem.h:6,
                    from include/linux/fs.h:30,
                    from include/linux/seq_file.h:10,
                    from include/linux/pinctrl/consumer.h:17,
                    from include/linux/pinctrl/devinfo.h:21,
                    from include/linux/device.h:24,
                    from include/linux/dma-mapping.h:6,
                    from include/drm/drmP.h:37,
                    from drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c:29:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c: In function 'TxStreamUpCallback':
   drivers/staging/xilinx/hdmi/xilinx_drm_hdmi.c:284:21: warning: unused variable 'HdmiTxSsVidStreamPtr' [-Wunused-variable]
     XVidC_VideoStream *HdmiTxSsVidStreamPtr;
                        ^~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_hw.h:51:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c:45:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_hw.h:51,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c:45:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_hw.h:51:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c:45:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx_hw.h:51,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-tx/xv_hdmitx.c:45:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~

vim +65 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h

7290bf423 Rohit Consul 2017-05-05  62  
7290bf423 Rohit Consul 2017-05-05  63  static inline void Xil_Out32(INTPTR Addr, u32 Value)
7290bf423 Rohit Consul 2017-05-05  64  {
7290bf423 Rohit Consul 2017-05-05 @65  	iowrite32(Value, (volatile void *)Addr);
7290bf423 Rohit Consul 2017-05-05  66  }
7290bf423 Rohit Consul 2017-05-05  67  static inline u32 Xil_In32(INTPTR Addr)
7290bf423 Rohit Consul 2017-05-05  68  {
7290bf423 Rohit Consul 2017-05-05 @69  	return ioread32((const volatile void *)Addr);
7290bf423 Rohit Consul 2017-05-05  70  }
7290bf423 Rohit Consul 2017-05-05  71  

:::::: The code at line 65 was first introduced by commit
:::::: 7290bf423f13ec6a996b443160bfd4a1f9629deb phy: xilinx-vphy: Initial release of xilinx video phy soft IP driver

:::::: TO: Rohit Consul <rohitco@xilinx.com>
:::::: CC: Jeffrey Mouroux <jmouroux@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56434 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/2e8bb378/attachment-0001.gz>
