From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 18 Jun 2016 21:22:55 +0800
Subject: [arm:for-next 9/14] arch/arm/include/asm/uaccess.h:379:42: error:
 implicit declaration of function '__put_user_check'
Message-ID: <201606182153.2XMyptyA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
head:   c1ac58529faba8791f75b0a75197ca317bfa67aa
commit: f59ae79b6311e6c95f21047a6cb8d052eaaa3340 [9/14] ARM: uaccess: remove put_user() code duplication
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f59ae79b6311e6c95f21047a6cb8d052eaaa3340
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:5:0,
                    from arch/arm/kernel/process.c:27:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
--
   In file included from include/linux/uaccess.h:5:0,
                    from arch/arm/kernel/ptrace.c:22:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   arch/arm/kernel/ptrace.c: In function 'arch_ptrace':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> arch/arm/kernel/ptrace.c:279:9: note: in expansion of macro 'put_user'
     return put_user(tmp, ret);
            ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   arch/arm/kernel/ptrace.c:852:10: note: in expansion of macro 'put_user'
       ret = put_user(task_thread_info(child)->tp_value[0],
             ^
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from drivers/char/mem.c:19:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/poll.h:11:0,
                    from drivers/char/random.c:246:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   drivers/char/random.c: In function 'random_ioctl':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> drivers/char/random.c:1538:7: note: in expansion of macro 'put_user'
      if (put_user(ent_count, p))
          ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> drivers/char/random.c:1538:7: note: in expansion of macro 'put_user'
      if (put_user(ent_count, p))
          ^
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from include/linux/audit.h:29,
                    from include/linux/fsnotify.h:15,
                    from fs/read_write.c:12:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   fs/read_write.c: In function 'SyS_sendfile':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   In file included from include/linux/linkage.h:4:0,
                    from arch/arm/include/asm/bug.h:4,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from fs/read_write.c:7:
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   include/linux/compiler.h:170:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
>> fs/read_write.c:1393:16: note: in expansion of macro 'put_user'
      if (unlikely(put_user(pos, offset)))
                   ^
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from include/linux/audit.h:29,
                    from include/linux/fsnotify.h:15,
                    from fs/read_write.c:12:
   fs/read_write.c: In function 'SyS_sendfile64':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   In file included from include/linux/linkage.h:4:0,
                    from arch/arm/include/asm/bug.h:4,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/gfp.h:4,
                    from include/linux/slab.h:14,
                    from fs/read_write.c:7:
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   include/linux/compiler.h:170:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   fs/read_write.c:1410:16: note: in expansion of macro 'put_user'
      if (unlikely(put_user(pos, offset)))
                   ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/poll.h:11:0,
                    from fs/pipe.c:9:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   fs/pipe.c: In function 'pipe_ioctl':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> fs/pipe.c:498:11: note: in expansion of macro 'put_user'
       return put_user(count, (int __user *)arg);
              ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/poll.h:11:0,
                    from include/linux/ring_buffer.h:7,
                    from include/linux/trace_events.h:5,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from fs/ioctl.c:7:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   fs/ioctl.c: In function 'ioctl_fibmap':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> fs/ioctl.c:64:9: note: in expansion of macro 'put_user'
     return put_user(res, p);
            ^
   fs/ioctl.c: In function 'do_vfs_ioctl':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/ioctl.c:659:10: note: in expansion of macro 'put_user'
      return put_user(inode->i_sb->s_blocksize, argp);
             ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> fs/ioctl.c:64:9: note: in expansion of macro 'put_user'
     return put_user(res, p);
            ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/ioctl.c:487:10: note: in expansion of macro 'put_user'
      return put_user(i_size_read(inode) - filp->f_pos, p);
             ^
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from include/linux/tty.h:6,
                    from include/linux/audit.h:29,
                    from include/linux/fsnotify.h:15,
                    from fs/readdir.c:16:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   fs/readdir.c: In function 'SyS_getdents':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> fs/readdir.c:235:7: note: in expansion of macro 'put_user'
      if (put_user(buf.ctx.pos, &lastdirent->d_off))
          ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/uaccess.h:5:0,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:10,
                    from include/linux/mempolicy.h:14,
                    from kernel/fork.c:21:
>> arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
>> arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   kernel/fork.c: In function 'mm_release':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> kernel/fork.c:931:4: note: in expansion of macro 'put_user'
       put_user(0, tsk->clear_child_tid);
       ^
   kernel/fork.c: In function '_do_fork':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' may be used uninitialized in this function [-Wmaybe-uninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   kernel/fork.c:1778:4: note: in expansion of macro 'put_user'
       put_user(nr, parent_tidptr);
       ^
   cc1: some warnings being treated as errors
..

vim +/__put_user_check +379 arch/arm/include/asm/uaccess.h

   373			uaccess_restore(__ua_flags);				\
   374		} while (0)
   375	
   376	#define put_user(x, ptr)						\
   377	({									\
   378		int __pu_err;							\
 > 379		__put_user_switch((x), (ptr), __pu_err, __put_user_check);	\
   380		__pu_err;							\
   381	})
   382	
   383	#define __put_user(x, ptr)						\
   384	({									\
   385		long __pu_err = 0;						\
   386		__put_user_switch((x), (ptr), __pu_err, __put_user_nocheck);	\
   387		__pu_err;							\
   388	})
   389	
   390	#define __put_user_error(x, ptr, err)					\
   391	({									\
   392		__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
   393		(void) 0;							\
   394	})
   395	
 > 396	#define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
   397		do {								\
   398			unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
   399			__put_user_nocheck_##__size(x, __pu_addr, __err);	\

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5584 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/522fba94/attachment-0001.obj>
