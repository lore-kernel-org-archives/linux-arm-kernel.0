From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 14 Dec 2017 06:58:31 +0800
Subject: [xlnx:2017.3_video_ea 6585/6607]
 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:49:19: warning: passing
 argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target
 type
Message-ID: <201712140629.SHN35MWJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.3_video_ea
head:   af045f9682c65a0c26afb2f638603d3c01079222
commit: b58dab7f9cf13f9004a220128317fc85a1b75b63 [6585/6607] staging: xilinx: Add xilinx hdmi drivers to staging area
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b58dab7f9cf13f9004a220128317fc85a1b75b63
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hw.h:49:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy.h:95,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:37:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:49:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:24:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy_hw.h:49:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xvphy.h:95,
                    from drivers/staging/xilinx/hdmi/include/linux/phy/phy-vphy.h:22,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:37:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:53:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:24,
                    from arch/sh/include/asm/hardirq.h:5,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from drivers/staging/xilinx/hdmi/xilinx-hdmirx.c:24:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
--
   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.h:92,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_i.h:51,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c:41:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:49:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:45,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.h:92,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_i.h:51,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c:41:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.h:92,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_i.h:51,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c:41:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:53:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:45,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx.h:92,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_i.h:51,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c:41:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c: In function 'XHdcp22Tx_RsaEncryptMsg':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_tx_crypt.c:254:1: warning: the frame size of 1536 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^
--
   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx.h:105,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_i.h:47,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c:46:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_Out32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:49:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(Value, (volatile void *)Addr);
                      ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:45,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx.h:105,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_i.h:47,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c:46:
   include/asm-generic/iomap.h:41:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59:0,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx.h:105,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_i.h:47,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c:46:
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h: In function 'Xil_In32':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:53:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32((const volatile void *)Addr);
                     ^
   In file included from arch/sh/include/asm/io.h:20:0,
                    from include/linux/io.h:25,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h:45,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr_l.h:59,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xtmrctr.h:162,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx.h:105,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_i.h:47,
                    from drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c:46:
   include/asm-generic/iomap.h:31:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c: In function 'XHdcp22Rx_CalcMontNPrime':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp22_rx_crypt.c:169:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^

vim +49 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xil_io.h

73634d89 Rohit Consul 2017-10-31  46  
73634d89 Rohit Consul 2017-10-31  47  static inline void Xil_Out32(INTPTR Addr, u32 Value)
73634d89 Rohit Consul 2017-10-31  48  {
73634d89 Rohit Consul 2017-10-31 @49  	iowrite32(Value, (volatile void *)Addr);
73634d89 Rohit Consul 2017-10-31  50  }
73634d89 Rohit Consul 2017-10-31  51  static inline u32 Xil_In32(INTPTR Addr)
73634d89 Rohit Consul 2017-10-31  52  {
73634d89 Rohit Consul 2017-10-31 @53  	return ioread32((const volatile void *)Addr);
73634d89 Rohit Consul 2017-10-31  54  }
73634d89 Rohit Consul 2017-10-31  55  

:::::: The code at line 49 was first introduced by commit
:::::: 73634d891211ef92c9d8c789a1ccc002118164ba phy: xilinx-vphy: Initial release of xilinx video phy soft IP driver

:::::: TO: Rohit Consul <rohit.consul@xilinx.com>
:::::: CC: Jeffrey Mouroux <jmouroux@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/eb9270fc/attachment-0001.gz>
