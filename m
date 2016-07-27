From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 28 Jul 2016 01:39:16 +0800
Subject: [xlnx:master 2616/2625]
 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33:
 error: field 'sync_fence_waiter' has incomplete type
Message-ID: <201607280109.XPweA599%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: 9eb0420ec8683897b7fcea28e3b915c575a01e36 [2616/2625] Merge tag 'v4.6' into master
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        git checkout 9eb0420ec8683897b7fcea28e3b915c575a01e36
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:19:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_soft_job.h:16,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_ukk_soft_job.c:19:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:37: warning: 'struct sync_fence' declared inside parameter list will not be visible outside of this definition or declaration
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
                                        ^~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_soft_job.h:16:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_ukk_soft_job.c:19:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33: error: field 'sync_fence_waiter' has incomplete type
     struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
                                    ^~~~~~~~~~~~~~~~~
--
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:19:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:11:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:37: warning: 'struct sync_fence' declared inside parameter list will not be visible outside of this definition or declaration
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
                                        ^~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:11:0:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33: error: field 'sync_fence_waiter' has incomplete type
     struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
                                    ^~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c: In function 'mali_timeline_sync_fence_callback':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:82:44: error: dereferencing pointer to incomplete type 'struct sync_fence'
     int fence_status = atomic_read(&sync_fence->status);
                                               ^~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:145:2: error: implicit declaration of function 'sync_fence_put' [-Werror=implicit-function-declaration]
     sync_fence_put(sync_fence);
     ^~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c: In function 'mali_timeline_cancel_sync_fence_waiters':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:844:13: error: implicit declaration of function 'sync_fence_cancel_async' [-Werror=implicit-function-declaration]
       if (0 == sync_fence_cancel_async(tracker->sync_fence, &tracker->sync_fence_waiter)) {
                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c: In function 'mali_timeline_system_create_waiters_and_unlock':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:1130:16: error: implicit declaration of function 'sync_fence_fdget' [-Werror=implicit-function-declaration]
      sync_fence = sync_fence_fdget(tracker->fence.sync_fd);
                   ^~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:1130:14: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      sync_fence = sync_fence_fdget(tracker->fence.sync_fd);
                 ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:1143:3: error: implicit declaration of function 'sync_fence_waiter_init' [-Werror=implicit-function-declaration]
      sync_fence_waiter_init(&tracker->sync_fence_waiter, mali_timeline_sync_fence_callback);
      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.c:1144:9: error: implicit declaration of function 'sync_fence_wait_async' [-Werror=implicit-function-declaration]
      ret = sync_fence_wait_async(sync_fence, &tracker->sync_fence_waiter);
            ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:19:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.h:21,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:11:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:37: warning: 'struct sync_fence' declared inside parameter list will not be visible outside of this definition or declaration
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
                                        ^~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.h:21:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:11:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33: error: field 'sync_fence_waiter' has incomplete type
     struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
                                    ^~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c: In function 'mali_timeline_fence_wait_check_status':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:102:16: error: implicit declaration of function 'sync_fence_fdget' [-Werror=implicit-function-declaration]
      sync_fence = sync_fence_fdget(fence->sync_fd);
                   ^~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:102:14: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      sync_fence = sync_fence_fdget(fence->sync_fd);
                 ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:107:36: error: dereferencing pointer to incomplete type 'struct sync_fence'
       if (0 == atomic_read(&sync_fence->status)) {
                                       ^~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_fence_wait.c:122:3: error: implicit declaration of function 'sync_fence_put' [-Werror=implicit-function-declaration]
      sync_fence_put(sync_fence);
      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:19:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.h:20,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:11:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:37: warning: 'struct sync_fence' declared inside parameter list will not be visible outside of this definition or declaration
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
                                        ^~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.h:20:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:11:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33: error: field 'sync_fence_waiter' has incomplete type
     struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
                                    ^~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c: In function 'mali_timeline_sync_fence_create':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:107:16: error: implicit declaration of function 'sync_fence_fdget' [-Werror=implicit-function-declaration]
      sync_fence = sync_fence_fdget(fence->sync_fd);
                   ^~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:107:14: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      sync_fence = sync_fence_fdget(fence->sync_fd);
                 ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:128:34: warning: passing argument 1 of 'mali_sync_fence_fd_alloc' from incompatible pointer type [-Wincompatible-pointer-types]
     return mali_sync_fence_fd_alloc(sync_fence_acc);
                                     ^~~~~~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:19:0,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.h:20,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:11:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:5: note: expected 'struct sync_fence *' but argument is of type 'struct sync_fence *'
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline_sync_fence.c:132:3: error: implicit declaration of function 'sync_fence_put' [-Werror=implicit-function-declaration]
      sync_fence_put(sync_fence_acc);
      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:11:0:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:37: warning: 'struct sync_fence' declared inside parameter list will not be visible outside of this definition or declaration
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
                                        ^~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:15:0:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h:186:33: error: field 'sync_fence_waiter' has incomplete type
     struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
                                    ^~~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:22:25: error: field 'sync_pt' has incomplete type
     struct sync_pt         sync_pt;
                            ^~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/seq_file.h:6,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:22,
                    from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:11:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'to_mali_sync_pt':
   include/linux/kernel.h:824:48: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:49:9: note: in expansion of macro 'container_of'
     return container_of(pt, struct mali_sync_pt, sync_pt);
            ^~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'timeline_dup':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:65:9: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
     new_pt = sync_pt_create(mpt->sync_tl, sizeof(struct mali_sync_pt));
            ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: At top level:
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:186:2: error: unknown field 'dup' specified in initializer
     .dup            = timeline_dup,
     ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:186:20: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .dup            = timeline_dup,
                       ^~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:186:20: note: (near initialization for 'mali_timeline_ops.has_signaled')
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:187:20: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .has_signaled   = timeline_has_signaled,
                       ^~~~~~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:187:20: note: (near initialization for 'mali_timeline_ops.has_signaled')
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:188:2: error: unknown field 'compare' specified in initializer
     .compare        = timeline_compare,
     ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:188:20: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .compare        = timeline_compare,
                       ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:188:20: note: (near initialization for 'mali_timeline_ops.timeline_value_str')
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:189:2: error: unknown field 'free_pt' specified in initializer
     .free_pt        = timeline_free_pt,
     ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:189:20: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .free_pt        = timeline_free_pt,
                       ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:189:20: note: (near initialization for 'mali_timeline_ops.fence_value_str')
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:190:2: error: unknown field 'release_obj' specified in initializer
     .release_obj    = timeline_release,
     ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:190:20: warning: excess elements in struct initializer
     .release_obj    = timeline_release,
                       ^~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:190:20: note: (near initialization for 'mali_timeline_ops')
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:194:2: error: unknown field 'pt_value_str' specified in initializer
     .pt_value_str = timeline_pt_value_str,
     ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:194:18: warning: excess elements in struct initializer
     .pt_value_str = timeline_pt_value_str,
                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:194:18: note: (near initialization for 'mali_timeline_ops')
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:226:5: error: conflicting types for 'mali_sync_fence_fd_alloc'
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence)
        ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:11:0:
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.h:59:5: note: previous declaration of 'mali_sync_fence_fd_alloc' was here
    s32 mali_sync_fence_fd_alloc(struct sync_fence *sync_fence);
        ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'mali_sync_fence_fd_alloc':
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:230:7: error: implicit declaration of function 'get_unused_fd' [-Werror=implicit-function-declaration]
     fd = get_unused_fd();
          ^~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:232:3: error: implicit declaration of function 'sync_fence_put' [-Werror=implicit-function-declaration]
      sync_fence_put(sync_fence);
      ^~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:235:2: error: implicit declaration of function 'sync_fence_install' [-Werror=implicit-function-declaration]
     sync_fence_install(sync_fence, fd);
     ^~~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'mali_sync_fence_merge':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:247:15: error: implicit declaration of function 'sync_fence_merge' [-Werror=implicit-function-declaration]
     sync_fence = sync_fence_merge("mali_merge_fence", sync_fence1, sync_fence2);
                  ^~~~~~~~~~~~~~~~
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:247:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     sync_fence = sync_fence_merge("mali_merge_fence", sync_fence1, sync_fence2);
                ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'mali_sync_flag_create_pt':
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:345:5: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
     pt = sync_pt_create(flag->sync_tl, sizeof(struct mali_sync_pt));
        ^
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'mali_sync_flag_create_fence':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:368:15: error: implicit declaration of function 'sync_fence_create' [-Werror=implicit-function-declaration]
     sync_fence = sync_fence_create("mali_flag_fence", sync_pt);
                  ^~~~~~~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:368:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     sync_fence = sync_fence_create("mali_flag_fence", sync_pt);
                ^
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:370:3: error: implicit declaration of function 'sync_pt_free' [-Werror=implicit-function-declaration]
      sync_pt_free(sync_pt);
      ^~~~~~~~~~~~
   drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c: In function 'to_mali_sync_pt':
>> drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/linux/mali_sync.c:50:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +/sync_fence_waiter +186 drivers/staging/mali/DX910-SW-99002-r5p1-01rel0/driver/src/devicedrv/mali/common/mali_timeline.h

8e905b3b Michal Simek 2015-06-10  170  
8e905b3b Michal Simek 2015-06-10  171  	struct mali_timeline_tracker  *timeline_next; /**< Next tracker on timeline's tracker list */
8e905b3b Michal Simek 2015-06-10  172  	struct mali_timeline_tracker  *timeline_prev; /**< Previous tracker on timeline's tracker list */
8e905b3b Michal Simek 2015-06-10  173  
8e905b3b Michal Simek 2015-06-10  174  	u32                            trigger_ref_count; /**< When zero tracker will be activated */
8e905b3b Michal Simek 2015-06-10  175  	mali_timeline_activation_error activation_error;  /**< Activation error. */
8e905b3b Michal Simek 2015-06-10  176  	struct mali_timeline_fence     fence;             /**< Fence used to create this tracker */
8e905b3b Michal Simek 2015-06-10  177  
8e905b3b Michal Simek 2015-06-10  178  	/* Single-linked list of waiters.  Sorted in order of insertions with
8e905b3b Michal Simek 2015-06-10  179  	 * tail pointing to first waiter. */
8e905b3b Michal Simek 2015-06-10  180  	struct mali_timeline_waiter   *waiter_head;
8e905b3b Michal Simek 2015-06-10  181  	struct mali_timeline_waiter   *waiter_tail;
8e905b3b Michal Simek 2015-06-10  182  
8e905b3b Michal Simek 2015-06-10  183  #if defined(CONFIG_SYNC)
8e905b3b Michal Simek 2015-06-10  184  	/* These are only used if the tracker is waiting on a sync fence. */
8e905b3b Michal Simek 2015-06-10  185  	struct mali_timeline_waiter   *waiter_sync; /**< A direct pointer to timeline waiter representing sync fence. */
8e905b3b Michal Simek 2015-06-10 @186  	struct sync_fence_waiter       sync_fence_waiter; /**< Used to connect sync fence and tracker in sync fence wait callback. */
8e905b3b Michal Simek 2015-06-10  187  	struct sync_fence             *sync_fence;   /**< The sync fence this tracker is waiting on. */
8e905b3b Michal Simek 2015-06-10  188  	_mali_osk_list_t               sync_fence_cancel_list; /**< List node used to cancel sync fence waiters. */
8e905b3b Michal Simek 2015-06-10  189  #endif /* defined(CONFIG_SYNC) */
8e905b3b Michal Simek 2015-06-10  190  
8e905b3b Michal Simek 2015-06-10  191  	struct mali_timeline_system   *system;       /**< Timeline system. */
8e905b3b Michal Simek 2015-06-10  192  	struct mali_timeline          *timeline;     /**< Timeline, or NULL if not on a timeline. */
8e905b3b Michal Simek 2015-06-10  193  	enum mali_timeline_tracker_type type;        /**< Type of tracker. */
8e905b3b Michal Simek 2015-06-10  194  	void                          *job;          /**< Owner of tracker. */

:::::: The code at line 186 was first introduced by commit
:::::: 8e905b3b33fa6f3f2f97591500b53d8a8245df29 staging: mali: Add r5p1-01rel0 and r5p2-00rel0 drivers

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54724 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/282613de/attachment-0001.obj>
