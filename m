From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Feb 2018 13:00:42 +0800
Subject: [PATCH v3 5/5] linux/const.h: move BIT(_ULL) to linux/const.h
 for use in assembly
In-Reply-To: <1519301715-31798-6-git-send-email-yamada.masahiro@socionext.com>
References: <1519301715-31798-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201802241211.z062884N%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/linux-const-h-cleanups-of-macros-such-as-UL-_BITUL-BIT-etc/20180224-110702
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/const.h:4:0,
                    from include/linux/bitops.h:4,
                    from include/linux/kernel.h:11,
                    from include/linux/interrupt.h:6,
                    from drivers/infiniband/hw/bnxt_re/ib_verbs.c:39:
   drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_query_device':
>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _BITUL(x) (_UL(1) << (x))
                              ^
>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
    #define BIT(x)  (_BITUL(x))
                     ^~~~~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
    #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
                                     ^~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
    #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:149:25: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
     ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
                            ^~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_reg_user_mr':
>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _BITUL(x) (_UL(1) << (x))
                              ^
>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
    #define BIT(x)  (_BITUL(x))
                     ^~~~~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
    #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
                                     ^~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
    #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:3588:15: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
     if (length > BNXT_RE_MAX_MR_SIZE) {
                  ^~~~~~~~~~~~~~~~~~~
>> include/uapi/linux/const.h:28:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _BITUL(x) (_UL(1) << (x))
                              ^
>> include/linux/const.h:9:18: note: in expansion of macro '_BITUL'
    #define BIT(x)  (_BITUL(x))
                     ^~~~~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
    #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
                                     ^~~
   drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
    #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/infiniband/hw/bnxt_re/ib_verbs.c:3590:12: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
       length, BNXT_RE_MAX_MR_SIZE);
               ^~~~~~~~~~~~~~~~~~~

vim +28 include/uapi/linux/const.h

5289f87f3 Masahiro Yamada 2018-02-22  27  
4fac4e1b2 Masahiro Yamada 2018-02-22 @28  #define _BITUL(x)	(_UL(1) << (x))
4fac4e1b2 Masahiro Yamada 2018-02-22  29  #define _BITULL(x)	(_ULL(1) << (x))
2fc016c5b H. Peter Anvin  2013-04-27  30  

:::::: The code at line 28 was first introduced by commit
:::::: 4fac4e1b26bc6cfec630fb48920c391d99a44940 linux/const.h: refactor _BITUL and _BITULL a bit

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180224/e8afbf38/attachment-0001.gz>
