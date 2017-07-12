From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Jul 2017 06:37:31 +0800
Subject: [xlnx:master 737/744]
 drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c:516:148: warning: comparison of
 distinct pointer types lacks a cast
Message-ID: <201707130629.i1adGEgm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   50dbfdba9101210db33a5a311b85a7409ab62278
commit: 40bacdf28c31f6f9d6e628940cfaa98db02c5e16 [737/744] drm: xilinx: Kconfig: Add config option for DPSUB debugfs
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 40bacdf28c31f6f9d6e628940cfaa98db02c5e16
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c: In function 'xilinx_dp_sub_debugfs_output_display_format_read':
>> drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c:516:148: warning: comparison of distinct pointer types lacks a cast
     out_str_len = min(XILINX_DP_SUB_DEBUGFS_READ_MAX_SIZE, out_str_len);
                                                                                                                                                       ^ 
   drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c: In function 'xilinx_dp_sub_debugfs_background_color_read':
   drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c:533:148: warning: comparison of distinct pointer types lacks a cast
     out_str_len = min(XILINX_DP_SUB_DEBUGFS_READ_MAX_SIZE, out_str_len);
                                                                                                                                                       ^ 
   drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c: In function 'xilinx_dp_sub_debugfs_read':
   drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c:608:149: warning: comparison of distinct pointer types lacks a cast
      out_str_len = min(XILINX_DP_SUB_DEBUGFS_READ_MAX_SIZE,
                                                                                                                                                        ^ 

vim +516 drivers/gpu//drm/xilinx/xilinx_drm_dp_sub.c

94d31bdd Tejas Upadhyay 2017-06-06  506  
94d31bdd Tejas Upadhyay 2017-06-06  507  static ssize_t
94d31bdd Tejas Upadhyay 2017-06-06  508  xilinx_dp_sub_debugfs_output_display_format_read(char **kern_buff)
94d31bdd Tejas Upadhyay 2017-06-06  509  {
94d31bdd Tejas Upadhyay 2017-06-06  510  	size_t out_str_len;
94d31bdd Tejas Upadhyay 2017-06-06  511  
94d31bdd Tejas Upadhyay 2017-06-06  512  	dp_sub_debugfs.testcase = DP_SUB_TC_NONE;
94d31bdd Tejas Upadhyay 2017-06-06  513  	xilinx_dp_sub_debugfs_output_format(dp_sub_debugfs.output_fmt);
94d31bdd Tejas Upadhyay 2017-06-06  514  
94d31bdd Tejas Upadhyay 2017-06-06  515  	out_str_len = strlen("Success");
94d31bdd Tejas Upadhyay 2017-06-06 @516  	out_str_len = min(XILINX_DP_SUB_DEBUGFS_READ_MAX_SIZE, out_str_len);
94d31bdd Tejas Upadhyay 2017-06-06  517  	snprintf(*kern_buff, out_str_len, "%s", "Success");
94d31bdd Tejas Upadhyay 2017-06-06  518  
94d31bdd Tejas Upadhyay 2017-06-06  519  	return 0;
94d31bdd Tejas Upadhyay 2017-06-06  520  }
94d31bdd Tejas Upadhyay 2017-06-06  521  

:::::: The code at line 516 was first introduced by commit
:::::: 94d31bdd30d4bfba972eb169e3bf5f1a607cc273 drm: xilinx: dp_sub: Add debugfs testcases

:::::: TO: Tejas Upadhyay <tejas.upadhyay@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56405 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/84c6a010/attachment-0001.gz>
