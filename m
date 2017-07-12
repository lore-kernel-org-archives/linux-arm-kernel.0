From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Jul 2017 04:17:04 +0800
Subject: [xlnx:master 735/744] drivers/dma//xilinx/xilinx_dpdma.c:415:148:
 warning: comparison of distinct pointer types lacks a cast
Message-ID: <201707130402.2oQ3uHhl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   50dbfdba9101210db33a5a311b85a7409ab62278
commit: 6ffeb8a9d754dd608e609788b83b87fcf8a706be [735/744] dma: xilinx: Kconfig: Add config option for DPDMA debugfs
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6ffeb8a9d754dd608e609788b83b87fcf8a706be
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/dma//xilinx/xilinx_dpdma.c: In function 'xilinx_dpdma_debugfs_desc_done_intr_read':
>> drivers/dma//xilinx/xilinx_dpdma.c:415:148: warning: comparison of distinct pointer types lacks a cast
     out_str_len = min(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE, out_str_len);
                                                                                                                                                       ^ 
   drivers/dma//xilinx/xilinx_dpdma.c: In function 'xilinx_dpdma_debugfs_read':
   drivers/dma//xilinx/xilinx_dpdma.c:491:149: warning: comparison of distinct pointer types lacks a cast
      out_str_len = min(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
                                                                                                                                                        ^ 

vim +415 drivers/dma//xilinx/xilinx_dpdma.c

b13304d0 Tejas Upadhyay 2017-06-06  407  
b13304d0 Tejas Upadhyay 2017-06-06  408  static ssize_t xilinx_dpdma_debugfs_desc_done_intr_read(char **kern_buff)
b13304d0 Tejas Upadhyay 2017-06-06  409  {
b13304d0 Tejas Upadhyay 2017-06-06  410  	size_t out_str_len;
b13304d0 Tejas Upadhyay 2017-06-06  411  
b13304d0 Tejas Upadhyay 2017-06-06  412  	dpdma_debugfs.testcase = DPDMA_TC_NONE;
b13304d0 Tejas Upadhyay 2017-06-06  413  
b13304d0 Tejas Upadhyay 2017-06-06  414  	out_str_len = strlen(XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR);
b13304d0 Tejas Upadhyay 2017-06-06 @415  	out_str_len = min(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE, out_str_len);
b13304d0 Tejas Upadhyay 2017-06-06  416  	snprintf(*kern_buff, out_str_len, "%d",
b13304d0 Tejas Upadhyay 2017-06-06  417  		 dpdma_debugfs.xilinx_dpdma_intr_done_count);
b13304d0 Tejas Upadhyay 2017-06-06  418  
b13304d0 Tejas Upadhyay 2017-06-06  419  	return 0;
b13304d0 Tejas Upadhyay 2017-06-06  420  }
b13304d0 Tejas Upadhyay 2017-06-06  421  

:::::: The code at line 415 was first introduced by commit
:::::: b13304d0be52e93b7ac781e9e808f3f1dd253690 dma: xilinx: dpdma: Add debugfs testcases

:::::: TO: Tejas Upadhyay <tejas.upadhyay@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56398 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/5fd85c71/attachment-0001.gz>
