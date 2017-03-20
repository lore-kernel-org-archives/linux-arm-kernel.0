From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Mar 2017 14:22:26 +0800
Subject: [alsa-devel] [PATCH v3 07/11] IIO: consumer: allow to set buffer
 sizes
In-Reply-To: <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201703201442.9pSvTRk6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.11-rc3]
[cannot apply to iio/togreg next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170320-133247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-randconfig-x073-201712 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from drivers/iio/buffer/industrialio-buffer-cb.c:8:
>> include/linux/export.h:67:20: error: redefinition of '__kstrtab_iio_channel_start_all_cb'
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
>> drivers/iio/buffer/industrialio-buffer-cb.c:124:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:67:20: note: previous definition of '__kstrtab_iio_channel_start_all_cb' was here
     static const char __kstrtab_##sym[]    \
                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-cb.c:117:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: error: redefinition of '__ksymtab_iio_channel_start_all_cb'
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
>> drivers/iio/buffer/industrialio-buffer-cb.c:124:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
    ^~~~~~~~~~~~~~~~~
   include/linux/export.h:70:36: note: previous definition of '__ksymtab_iio_channel_start_all_cb' was here
     static const struct kernel_symbol __ksymtab_##sym  \
                                       ^
   include/linux/export.h:100:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:107:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "_gpl")
     ^~~~~~~~~~~~~~~
   drivers/iio/buffer/industrialio-buffer-cb.c:117:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
    ^~~~~~~~~~~~~~~~~

vim +/__kstrtab_iio_channel_start_all_cb +67 include/linux/export.h

f5016932 Paul Gortmaker  2011-05-23  61  #endif
f5016932 Paul Gortmaker  2011-05-23  62  
f5016932 Paul Gortmaker  2011-05-23  63  /* For every exported symbol, place a struct in the __ksymtab section */
f2355416 Nicolas Pitre   2016-01-22  64  #define ___EXPORT_SYMBOL(sym, sec)					\
f5016932 Paul Gortmaker  2011-05-23  65  	extern typeof(sym) sym;						\
f5016932 Paul Gortmaker  2011-05-23  66  	__CRC_SYMBOL(sym, sec)						\
f5016932 Paul Gortmaker  2011-05-23 @67  	static const char __kstrtab_##sym[]				\
f5016932 Paul Gortmaker  2011-05-23  68  	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
b92021b0 Rusty Russell   2013-03-15  69  	= VMLINUX_SYMBOL_STR(sym);					\
b67067f1 Nicholas Piggin 2016-08-24  70  	static const struct kernel_symbol __ksymtab_##sym		\

:::::: The code at line 67 was first introduced by commit
:::::: f50169324df4ad942e544386d136216c8617636a module.h: split out the EXPORT_SYMBOL into export.h

:::::: TO: Paul Gortmaker <paul.gortmaker@windriver.com>
:::::: CC: Paul Gortmaker <paul.gortmaker@windriver.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26427 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/8ddf39b6/attachment-0001.gz>
