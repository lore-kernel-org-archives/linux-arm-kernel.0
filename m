From: lkp@intel.com (kbuild test robot)
Date: Sat, 29 Oct 2016 04:41:47 +0800
Subject: [PATCH v2 3/5] fpga manager: Add cyclone-ps-spi driver for
 Altera FPGAs
In-Reply-To: <202cdeff42a2de149c471630110a8b2657ccf5ca.1477669745.git.stillcompiling@gmail.com>
Message-ID: <201610290422.JEtRRTFh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joshua,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc2 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/lib-add-bitrev8x4/20161029-012535
config: openrisc-allmodconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/fpga/cyclone-ps-spi.c: In function 'cyclonespi_write':
   drivers/fpga/cyclone-ps-spi.c:89:19: error: 'SZ_4K' undeclared (first use in this function)
   drivers/fpga/cyclone-ps-spi.c:89:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/fpga/cyclone-ps-spi.c:89:19: error: type defaults to 'int' in declaration of '__UNIQUE_ID_min2_15'

vim +89 drivers/fpga/cyclone-ps-spi.c

    83		struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
    84		const char *fw_data = buf;
    85		const char *fw_data_end = fw_data + count;
    86	
    87		while (fw_data < fw_data_end) {
    88			int ret;
  > 89			size_t stride = min(fw_data_end - fw_data, SZ_4K);
    90	
    91			rev_buf((void *)fw_data, stride);
    92			ret = spi_write(conf->spi, fw_data, stride);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39284 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161029/d37f2726/attachment-0001.gz>
