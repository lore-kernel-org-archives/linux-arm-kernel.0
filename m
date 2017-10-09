From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Oct 2017 17:07:15 +0800
Subject: [PATCH v2 3/7] nvmem: imx-ocotp: Add support for banked OTP
 addressing
In-Reply-To: <1507502482-22518-4-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <201710091659.iGxbOAFn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc4 next-20170929]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/Fix-i-MX7D-OCOTP-write-support/20171009-155445
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

Note: the linux-review/Bryan-O-Donoghue/Fix-i-MX7D-OCOTP-write-support/20171009-155445 HEAD 5cdf7fb933d7043592aa21e657d9ffa0ef4eb764 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> drivers/nvmem/imx-ocotp.c:367:34: error: array type has incomplete element type 'struct octop_params'
    static const struct octop_params params[] = {
                                     ^~~~~~
   drivers/nvmem/imx-ocotp.c:368:4: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
       ^
   drivers/nvmem/imx-ocotp.c:368:4: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:368:18: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
                     ^
   drivers/nvmem/imx-ocotp.c:368:18: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:369:4: error: field name not in record or union initializer
     { .nregs = 64,  .bank_address_words = 0 },
       ^
   drivers/nvmem/imx-ocotp.c:369:4: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:369:18: error: field name not in record or union initializer
     { .nregs = 64,  .bank_address_words = 0 },
                     ^
   drivers/nvmem/imx-ocotp.c:369:18: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:370:4: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
       ^
   drivers/nvmem/imx-ocotp.c:370:4: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:370:18: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
                     ^
   drivers/nvmem/imx-ocotp.c:370:18: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:371:4: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
       ^
   drivers/nvmem/imx-ocotp.c:371:4: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:371:18: error: field name not in record or union initializer
     { .nregs = 128, .bank_address_words = 0 },
                     ^
   drivers/nvmem/imx-ocotp.c:371:18: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:372:4: error: field name not in record or union initializer
     { .nregs = 64,  .bank_address_words = 4 },
       ^
   drivers/nvmem/imx-ocotp.c:372:4: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:372:18: error: field name not in record or union initializer
     { .nregs = 64,  .bank_address_words = 4 },
                     ^
   drivers/nvmem/imx-ocotp.c:372:18: note: (near initialization for 'params')
   drivers/nvmem/imx-ocotp.c:367:34: warning: 'params' defined but not used [-Wunused-variable]
    static const struct octop_params params[] = {
                                     ^~~~~~

vim +367 drivers/nvmem/imx-ocotp.c

   366	
 > 367	static const struct octop_params params[] = {
   368		{ .nregs = 128, .bank_address_words = 0 },
   369		{ .nregs = 64,  .bank_address_words = 0 },
   370		{ .nregs = 128, .bank_address_words = 0 },
   371		{ .nregs = 128, .bank_address_words = 0 },
   372		{ .nregs = 64,  .bank_address_words = 4 },
   373	};
   374	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52085 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/e0c0f2b5/attachment-0001.gz>
