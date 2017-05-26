From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 26 May 2017 23:11:50 +0800
Subject: [xlnx:2017.1_video_ea 11/28]
 drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:2032:6:
 sparse: no newline at end of file
Message-ID: <201705262346.wWotiYkM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.1_video_ea
head:   79a0e60e9f6535e89d9923e3987398318f0ed4e2
commit: 2d6e151e6186db912023243302ba4880b00a8bad [11/28] staging: xilinx: Add xilinx hdmi drivers to staging area
reproduce:
        # apt-get install sparse
        git checkout 2d6e151e6186db912023243302ba4880b00a8bad
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:2032:6: sparse: no newline at end of file
   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.h:77,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:36:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_Out32':
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:65:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.h:77,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:36:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59:0,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.h:77,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:36:
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h: In function 'Xil_In32':
   drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:69:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xil_io.h:61,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx_hw.h:59,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirx.h:131,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss.h:77,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c:36:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~

vim +2032 drivers/staging/xilinx/hdmi/xilinx-hdmi-rx/xv_hdmirxss_hdcp.c

c7411816 Rohit Consul 2017-05-05  2016  #ifdef XPAR_XHDCP_NUM_INSTANCES
c7411816 Rohit Consul 2017-05-05  2017    // HDCP 1.4
c7411816 Rohit Consul 2017-05-05  2018    if (InstancePtr->Hdcp14Ptr) {
c7411816 Rohit Consul 2017-05-05  2019      XHdcp1x_SetRepeater(InstancePtr->Hdcp14Ptr, Set);
c7411816 Rohit Consul 2017-05-05  2020    }
c7411816 Rohit Consul 2017-05-05  2021  #endif
c7411816 Rohit Consul 2017-05-05  2022  
c7411816 Rohit Consul 2017-05-05  2023  #ifdef XPAR_XHDCP22_RX_NUM_INSTANCES
c7411816 Rohit Consul 2017-05-05  2024    // HDCP 2.2
c7411816 Rohit Consul 2017-05-05  2025    if (InstancePtr->Hdcp22Ptr) {
c7411816 Rohit Consul 2017-05-05  2026      XHdcp22Rx_SetRepeater(InstancePtr->Hdcp22Ptr, Set);
c7411816 Rohit Consul 2017-05-05  2027    }
c7411816 Rohit Consul 2017-05-05  2028  #endif
c7411816 Rohit Consul 2017-05-05  2029  
c7411816 Rohit Consul 2017-05-05  2030    return XST_SUCCESS;
c7411816 Rohit Consul 2017-05-05  2031  }

:::::: The code at line 2032 was first introduced by commit
:::::: c7411816e42074e95f4172fa006408f76294af04 media: xilinx-hdmi-rx: Initial release of xilinx hdmi-rx soft IP driver

:::::: TO: Rohit Consul <rohitco@xilinx.com>
:::::: CC: Jeffrey Mouroux <jmouroux@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
