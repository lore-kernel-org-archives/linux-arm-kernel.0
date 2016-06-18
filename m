From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 18 Jun 2016 21:25:15 +0800
Subject: [arm:for-next 9/14] block/ioctl.c:254:9: note: in expansion of macro
 'put_user'
Message-ID: <201606182111.Bg7wXMb1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
head:   c1ac58529faba8791f75b0a75197ca317bfa67aa
commit: f59ae79b6311e6c95f21047a6cb8d052eaaa3340 [9/14] ARM: uaccess: remove put_user() code duplication
config: arm-efm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f59ae79b6311e6c95f21047a6cb8d052eaaa3340
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:5:0,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:10,
                    from include/linux/blkdev.h:14,
                    from block/ioctl.c:2:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   block/ioctl.c: In function 'put_ushort':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> block/ioctl.c:254:9: note: in expansion of macro 'put_user'
     return put_user(val, (unsigned short __user *)arg);
            ^
   block/ioctl.c: In function 'put_long':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/ioctl.c:269:9: note: in expansion of macro 'put_user'
     return put_user(val, (long __user *)arg);
            ^
   block/ioctl.c: In function 'put_int':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/ioctl.c:259:9: note: in expansion of macro 'put_user'
     return put_user(val, (int __user *)arg);
            ^
   block/ioctl.c: In function 'put_uint':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/ioctl.c:264:9: note: in expansion of macro 'put_user'
     return put_user(val, (unsigned int __user *)arg);
            ^
   block/ioctl.c: In function 'put_ushort':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> block/ioctl.c:254:9: note: in expansion of macro 'put_user'
     return put_user(val, (unsigned short __user *)arg);
            ^
   block/ioctl.c: In function 'put_ulong':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/ioctl.c:274:9: note: in expansion of macro 'put_user'
     return put_user(val, (unsigned long __user *)arg);
            ^
   block/ioctl.c: In function 'put_u64':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/ioctl.c:279:9: note: in expansion of macro 'put_user'
     return put_user(val, (u64 __user *)arg);
            ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/uaccess.h:5:0,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:10,
                    from include/linux/blkdev.h:14,
                    from block/scsi_ioctl.c:23:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   block/scsi_ioctl.c: In function 'sg_get_version':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> block/scsi_ioctl.c:57:9: note: in expansion of macro 'put_user'
     return put_user(sg_version_num, p);
            ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> block/scsi_ioctl.c:57:9: note: in expansion of macro 'put_user'
     return put_user(sg_version_num, p);
            ^
   block/scsi_ioctl.c: In function 'scsi_get_idlun':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/scsi_ioctl.c:62:9: note: in expansion of macro 'put_user'
     return put_user(0, p);
            ^
   block/scsi_ioctl.c: In function 'scsi_get_bus':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/scsi_ioctl.c:67:9: note: in expansion of macro 'put_user'
     return put_user(0, p);
            ^
   block/scsi_ioctl.c: In function 'sg_get_reserved_size':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/scsi_ioctl.c:98:9: note: in expansion of macro 'put_user'
     return put_user(val, p);
            ^
   block/scsi_ioctl.c: In function 'sg_emulated_host':
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   block/scsi_ioctl.c:121:9: note: in expansion of macro 'put_user'
     return put_user(1, p);
            ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/uaccess.h:5:0,
                    from include/linux/highmem.h:8,
                    from include/linux/pagemap.h:10,
                    from include/linux/blkdev.h:14,
                    from include/linux/backing-dev.h:14,
                    from drivers/mtd/mtdchar.c:30:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   drivers/mtd/mtdchar.c: In function 'mtdchar_readoob':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> drivers/mtd/mtdchar.c:441:6: note: in expansion of macro 'put_user'
     if (put_user(ops.oobretlen, retp))
         ^
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from drivers/tty/tty_ioctl.c:10:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   include/asm-generic/termios.h: In function 'kernel_termios_to_user_termio':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
   include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   In file included from include/asm-generic/termios.h:5:0,
                    from arch/arm/include/generated/asm/termios.h:1,
                    from include/uapi/linux/termios.h:5,
                    from drivers/tty/tty_ioctl.c:10:
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   include/asm-generic/termios.h:58:6: note: in expansion of macro 'put_user'
     if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
         ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/poll.h:11:0,
                    from include/linux/rtc.h:56,
                    from include/linux/alarmtimer.h:7,
                    from fs/timerfd.c:11:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   fs/timerfd.c: In function 'timerfd_read':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> fs/timerfd.c:286:9: note: in expansion of macro 'put_user'
      res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
            ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/poll.h:11:0,
                    from include/linux/ring_buffer.h:7,
                    from include/linux/trace_events.h:5,
                    from include/trace/syscall.h:6,
                    from include/linux/syscalls.h:81,
                    from fs/binfmt_flat.c:37:
   arch/arm/include/asm/uaccess.h:396:0: warning: "__put_user_nocheck" redefined
    #define __put_user_nocheck(x, __pu_ptr, __err, __size)   \
    ^
   arch/arm/include/asm/uaccess.h:267:0: note: this is the location of the previous definition
    #define __put_user_nocheck __put_user_check
    ^
   fs/binfmt_flat.c: In function 'create_flat_tables':
   arch/arm/include/asm/uaccess.h:379:42: error: implicit declaration of function '__put_user_check' [-Werror=implicit-function-declaration]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:367:11: note: in definition of macro '__put_user_switch'
      case 1: __fn(__pu_val, __pu_ptr, __err, 1); break; \
              ^
>> fs/binfmt_flat.c:139:3: note: in expansion of macro 'put_user'
      put_user((unsigned long) envp, sp + 2);
      ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
>> fs/binfmt_flat.c:139:3: note: in expansion of macro 'put_user'
      put_user((unsigned long) envp, sp + 2);
      ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/binfmt_flat.c:140:3: note: in expansion of macro 'put_user'
      put_user((unsigned long) argv, sp + 1);
      ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/binfmt_flat.c:143:2: note: in expansion of macro 'put_user'
     put_user(argc, sp);
     ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/binfmt_flat.c:151:2: note: in expansion of macro 'put_user'
     put_user((unsigned long) NULL, argv);
     ^
>> arch/arm/include/asm/uaccess.h:379:42: warning: '__pu_err' is used uninitialized in this function [-Wuninitialized]
     __put_user_switch((x), (ptr), __pu_err, __put_user_check); \
                                             ^
   arch/arm/include/asm/uaccess.h:378:6: note: '__pu_err' was declared here
     int __pu_err;       \
         ^
   fs/binfmt_flat.c:159:2: note: in expansion of macro 'put_user'
     put_user((unsigned long) NULL, envp);
     ^
   cc1: some warnings being treated as errors
..

vim +/put_user +254 block/ioctl.c

d8e4bb8103 block/ioctl.c         Christoph Hellwig  2015-10-15  238  
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  239  	if (start & 511)
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  240  		return -EINVAL;
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  241  	if (len & 511)
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  242  		return -EINVAL;
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  243  	start >>= 9;
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  244  	len >>= 9;
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  245  
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  246  	if (start + len > (i_size_read(bdev->bd_inode) >> 9))
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  247  		return -EINVAL;
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  248  
d93ba7a5a9 block/ioctl.c         Martin K. Petersen 2015-01-20  249  	return blkdev_issue_zeroout(bdev, start, len, GFP_KERNEL, false);
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  250  }
66ba32dc16 block/ioctl.c         Martin K. Petersen 2012-09-18  251  
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  252  static int put_ushort(unsigned long arg, unsigned short val)
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  253  {
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16 @254  	return put_user(val, (unsigned short __user *)arg);
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  255  }
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  256  
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  257  static int put_int(unsigned long arg, int val)
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  258  {
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  259  	return put_user(val, (int __user *)arg);
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  260  }
^1da177e4c drivers/block/ioctl.c Linus Torvalds     2005-04-16  261  
ac481c20ef block/ioctl.c         Martin K. Petersen 2009-10-03  262  static int put_uint(unsigned long arg, unsigned int val)

:::::: The code at line 254 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 11217 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/5a249f9f/attachment-0001.obj>
