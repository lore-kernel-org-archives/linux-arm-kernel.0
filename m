From: lkp@intel.com (kbuild test robot)
Date: Tue, 21 Mar 2017 00:51:54 +0800
Subject: [PATCH v3 2/2] fpga: Add support for Xilinx LogiCORE PR Decoupler
In-Reply-To: <1489781473-30772-2-git-send-email-mdf@kernel.org>
Message-ID: <201703210022.AzJqOt2i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc3 next-20170320]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Moritz-Fischer/doc-Add-bindings-document-for-Xilinx-LogiCore-PR-Decoupler/20170320-074855
config: um-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xc9f1): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xc83c): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `vde_open_real':
   (.text+0xcb55): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoaddr':
   (.text+0x1d5e5): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametonetaddr':
   (.text+0x1d685): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoproto':
   (.text+0x1d8a5): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/built-in.o: In function `pcap_nametoport':
   (.text+0x1d6d7): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   drivers/built-in.o: In function `img_ascii_lcd_probe':
   drivers/auxdisplay/img-ascii-lcd.c:384: undefined reference to `devm_ioremap_resource'
   drivers/built-in.o: In function `xlnx_pr_decoupler_probe':
>> drivers/fpga/xilinx-pr-decoupler.c:92: undefined reference to `devm_ioremap_resource'
   collect2: error: ld returned 1 exit status

vim +92 drivers/fpga/xilinx-pr-decoupler.c

    86	
    87		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
    88		if (!priv)
    89			return -ENOMEM;
    90	
    91		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  > 92		priv->io_base = devm_ioremap_resource(&pdev->dev, res);
    93		if (IS_ERR(priv->io_base))
    94			return PTR_ERR(priv->io_base);
    95	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19096 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/945a23ff/attachment-0001.gz>
