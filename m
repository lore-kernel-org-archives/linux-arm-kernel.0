From: lkp@intel.com (kbuild test robot)
Date: Fri, 8 Jul 2016 06:25:21 +0800
Subject: [PATCH v4 4/5] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <f600ac1c747813b26c80149b6fdf32d42b114235.1467872014.git.maitysanchayan@gmail.com>
Message-ID: <201607080608.ppfp0BMi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.7-rc6]
[cannot apply to next-20160707]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sanchayan-Maity/Implement-SoC-driver-for-Vybrid/20160707-145122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-arm67 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/soc/fsl/soc-vf610.c: In function 'vf610_soc_probe':
>> drivers/soc/fsl/soc-vf610.c:73:21: error: implicit declaration of function 'of_nvmem_cell_get_direct' [-Werror=implicit-function-declaration]
     info->ocotp_cfg0 = of_nvmem_cell_get_direct(cfg0_node);
                        ^
>> drivers/soc/fsl/soc-vf610.c:73:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     info->ocotp_cfg0 = of_nvmem_cell_get_direct(cfg0_node);
                      ^
   drivers/soc/fsl/soc-vf610.c:79:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     info->ocotp_cfg1 = of_nvmem_cell_get_direct(cfg1_node);
                      ^
   cc1: some warnings being treated as errors

vim +/of_nvmem_cell_get_direct +73 drivers/soc/fsl/soc-vf610.c

    67		cfg1_node = of_find_node_by_name(soc_node, "cfg1");
    68		if (!cfg1_node) {
    69			ret = -ENODEV;
    70			goto out_cfg1_node;
    71		}
    72	
  > 73		info->ocotp_cfg0 = of_nvmem_cell_get_direct(cfg0_node);
    74		if (IS_ERR(info->ocotp_cfg0)) {
    75			ret = PTR_ERR(info->ocotp_cfg0);
    76			goto out_ocotp_cfg0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29428 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/c4426e6f/attachment-0001.obj>
