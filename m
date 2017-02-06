From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 01:39:37 +0800
Subject: [xlnx:master 2695/2699] drivers/fpga/zynqmp-fpga.c:60:2: error:
 implicit declaration of function '__flush_cache_user_range'
Message-ID: <201702070133.fsMcqvuN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   629041605b93343ad2e8971ceaac3edcef0b043b
commit: 280ca3f99087c428f2627bdeada12224596e0784 [2695/2699] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 280ca3f99087c428f2627bdeada12224596e0784
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/fpga/zynqmp-fpga.c: In function 'zynqmp_fpga_ops_write':
>> drivers/fpga/zynqmp-fpga.c:60:2: error: implicit declaration of function '__flush_cache_user_range' [-Werror=implicit-function-declaration]
     __flush_cache_user_range(kbuf, kbuf + size);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__flush_cache_user_range +60 drivers/fpga/zynqmp-fpga.c

    54	
    55		kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
    56		if (!kbuf)
    57			return -ENOMEM;
    58	
    59		memcpy(kbuf, buf, size);
  > 60		__flush_cache_user_range(kbuf, kbuf + size);
    61	
    62		/**
    63		 * Translate size from bytes to number of 32bit words that

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43592 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/6a8fbe12/attachment-0001.gz>
