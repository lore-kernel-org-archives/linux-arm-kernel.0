From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 10:15:03 +0800
Subject: [xlnx:master 2561/2625] include/linux/compiler.h:501:38: error: call
 to '__compiletime_assert_734' declared with attribute error:
 BUILD_BUG_ON
 failed: !IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64))
Message-ID: <201701251058.s9g5HdYf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: dadb5e41f28f9619debc9aae4ae543aa1dcd5be8 [2561/2625] staging: mali: r5p1-01rel0: Remove unused trace macros
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout dadb5e41f28f9619debc9aae4ae543aa1dcd5be8
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:15:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c: In function 'mali_ioctl':
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_734' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:734:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_post_notification_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_739' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_user_settings_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:739:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_user_settings_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_755' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_sw_counters_report_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:755:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_sw_counters_report_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_761' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_profiling_memory_usage_get_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:761:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_profiling_memory_usage_get_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_782' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_free_mem_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:782:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_free_mem_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_787' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_bind_mem_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:787:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_bind_mem_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_797' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_mem_write_safe_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:797:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_mem_write_safe_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_802' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_query_mmu_page_table_dump_size_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:802:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_query_mmu_page_table_dump_size_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_807' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_dump_mmu_page_table_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:807:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_dump_mmu_page_table_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_822' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_pp_start_job_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:822:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_pp_start_job_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_852' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_gp_number_of_cores_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:852:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_gp_number_of_cores_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_857' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_get_gp_core_version_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:857:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_get_gp_core_version_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_867' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_vsync_event_report_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:867:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_vsync_event_report_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_880' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_timeline_create_sync_fence_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:880:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_timeline_create_sync_fence_s), sizeof(u64)));
      ^~~~~~~~~~~~
>> include/linux/compiler.h:501:38: error: call to '__compiletime_assert_888' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(sizeof(_mali_uk_soft_job_signal_s), sizeof(u64))
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                         ^
   include/linux/compiler.h:484:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler.h:501:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_kernel_linux.c:888:3: note: in expansion of macro 'BUILD_BUG_ON'
      BUILD_BUG_ON(!IS_ALIGNED(sizeof(_mali_uk_soft_job_signal_s), sizeof(u64)));
      ^~~~~~~~~~~~

vim +/__compiletime_assert_734 +501 include/linux/compiler.h

9a8ab1c3 Daniel Santos  2013-02-21  485  		__compiletime_error_fallback(__cond);			\
9a8ab1c3 Daniel Santos  2013-02-21  486  	} while (0)
9a8ab1c3 Daniel Santos  2013-02-21  487  
9a8ab1c3 Daniel Santos  2013-02-21  488  #define _compiletime_assert(condition, msg, prefix, suffix) \
9a8ab1c3 Daniel Santos  2013-02-21  489  	__compiletime_assert(condition, msg, prefix, suffix)
9a8ab1c3 Daniel Santos  2013-02-21  490  
9a8ab1c3 Daniel Santos  2013-02-21  491  /**
9a8ab1c3 Daniel Santos  2013-02-21  492   * compiletime_assert - break build and emit msg if condition is false
9a8ab1c3 Daniel Santos  2013-02-21  493   * @condition: a compile-time constant condition to check
9a8ab1c3 Daniel Santos  2013-02-21  494   * @msg:       a message to emit if condition is false
9a8ab1c3 Daniel Santos  2013-02-21  495   *
9a8ab1c3 Daniel Santos  2013-02-21  496   * In tradition of POSIX assert, this macro will break the build if the
9a8ab1c3 Daniel Santos  2013-02-21  497   * supplied condition is *false*, emitting the supplied error message if the
9a8ab1c3 Daniel Santos  2013-02-21  498   * compiler has support to do so.
9a8ab1c3 Daniel Santos  2013-02-21  499   */
9a8ab1c3 Daniel Santos  2013-02-21  500  #define compiletime_assert(condition, msg) \
9a8ab1c3 Daniel Santos  2013-02-21 @501  	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
9a8ab1c3 Daniel Santos  2013-02-21  502  
47933ad4 Peter Zijlstra 2013-11-06  503  #define compiletime_assert_atomic_type(t)				\
47933ad4 Peter Zijlstra 2013-11-06  504  	compiletime_assert(__native_word(t),				\
47933ad4 Peter Zijlstra 2013-11-06  505  		"Need native word sized stores/loads for atomicity.")
47933ad4 Peter Zijlstra 2013-11-06  506  
9c3cdc1f Linus Torvalds 2008-05-10  507  /*
9c3cdc1f Linus Torvalds 2008-05-10  508   * Prevent the compiler from merging or refetching accesses.  The compiler
9c3cdc1f Linus Torvalds 2008-05-10  509   * is also forbidden from reordering successive instances of ACCESS_ONCE(),

:::::: The code at line 501 was first introduced by commit
:::::: 9a8ab1c39970a4938a72d94e6fd13be88a797590 bug.h, compiler.h: introduce compiletime_assert & BUILD_BUG_ON_MSG

:::::: TO: Daniel Santos <daniel.santos@pobox.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53782 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/d8b8c969/attachment-0001.gz>
