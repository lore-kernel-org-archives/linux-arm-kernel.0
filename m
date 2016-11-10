From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 11 Nov 2016 07:20:45 +0800
Subject: [clk:clk-qcom-8994 2/2] include/linux/module.h:213:1: error:
 expected ',' or ';' before 'extern'
Message-ID: <201611110732.1ceuZvsr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-qcom-8994
head:   cc800227108710c8f02255e61659b956b041eec3
commit: cc800227108710c8f02255e61659b956b041eec3 [2/2] clk: qcom: Add support for msm8994 global clock controller
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout cc800227108710c8f02255e61659b956b041eec3
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/clk/qcom/gcc-msm8994.c:20:0:
>> include/linux/module.h:213:1: error: expected ',' or ';' before 'extern'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
    ^
>> drivers/clk/qcom/gcc-msm8994.c:2265:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, gcc_msm8994_match_table);
    ^~~~~~~~~~~~~~~~~~~

vim +213 include/linux/module.h

^1da177e Linus Torvalds  2005-04-16  207  /* What your module does. */
^1da177e Linus Torvalds  2005-04-16  208  #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
^1da177e Linus Torvalds  2005-04-16  209  
cff26a51 Rusty Russell   2014-02-03  210  #ifdef MODULE
cff26a51 Rusty Russell   2014-02-03  211  /* Creates an alias so file2alias.c can find device table. */
^1da177e Linus Torvalds  2005-04-16  212  #define MODULE_DEVICE_TABLE(type, name)					\
6301939d Andrey Ryabinin 2015-02-13 @213  extern const typeof(name) __mod_##type##__##name##_device_table		\
cff26a51 Rusty Russell   2014-02-03  214    __attribute__ ((unused, alias(__stringify(name))))
cff26a51 Rusty Russell   2014-02-03  215  #else  /* !MODULE */
cff26a51 Rusty Russell   2014-02-03  216  #define MODULE_DEVICE_TABLE(type, name)

:::::: The code at line 213 was first introduced by commit
:::::: 6301939d97d079f0d3dbe71e750f4daf5d39fc33 module: fix types of device tables aliases

:::::: TO: Andrey Ryabinin <a.ryabinin@samsung.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/9bf381ab/attachment-0001.gz>
