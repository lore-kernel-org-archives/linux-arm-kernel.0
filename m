From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 02:10:25 +0800
Subject: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
In-Reply-To: <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <201601260255.zVUSYHdO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

[auto build test ERROR on v4.4-rc8]
[also build test ERROR on next-20160125]
[cannot apply to s390/features v4.5-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Yury-Norov/all-s390-move-wrapper-infrastructure-to-generic-headers/20160126-010134
config: s390-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

Note: the linux-review/Yury-Norov/all-s390-move-wrapper-infrastructure-to-generic-headers/20160126-010134 HEAD ef38065534a44f2efabd66ed0860b822cf98e49e builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_user.c: In function 'compat_SyS_fanotify_mark':
   fs/notify/fanotify/fanotify_user.c:913:1: error: implicit declaration of function '__TYPE_IS_PTR' [-Werror=implicit-function-declaration]
    COMPAT_SYSCALL_DEFINE6(fanotify_mark,
    ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/fanotify.h:4,
                    from include/linux/fanotify.h:4,
                    from fs/notify/fanotify/fanotify_user.c:1:
   fs/notify/fanotify/fanotify_user.c:914:5: error: expected expression before 'int'
        int, fanotify_fd, unsigned int, flags,
        ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
>> include/linux/syscalls.h:43:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                              ^
>> include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
>> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^
   fs/notify/fanotify/fanotify_user.c:913:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(fanotify_mark,
    ^
   In file included from include/linux/compat.h:19:0,
                    from fs/notify/fanotify/fanotify_user.c:16:
   fs/notify/fanotify/fanotify_user.c:914:5: error: expected expression before 'int'
        int, fanotify_fd, unsigned int, flags,
        ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
>> include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
>> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^
   fs/notify/fanotify/fanotify_user.c:913:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(fanotify_mark,
    ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/fanotify.h:4,
                    from include/linux/fanotify.h:4,
                    from fs/notify/fanotify/fanotify_user.c:1:
   fs/notify/fanotify/fanotify_user.c:914:23: error: expected expression before 'unsigned'
        int, fanotify_fd, unsigned int, flags,
                          ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:42:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                              ^
>> include/linux/syscalls.h:43:35: note: in expansion of macro '__MAP5'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                                      ^
>> include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
>> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^
   fs/notify/fanotify/fanotify_user.c:913:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(fanotify_mark,
    ^
   In file included from include/linux/compat.h:19:0,
                    from fs/notify/fanotify/fanotify_user.c:16:
   fs/notify/fanotify/fanotify_user.c:914:23: error: expected expression before 'unsigned'
        int, fanotify_fd, unsigned int, flags,
                          ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
>> include/linux/syscalls.h:43:35: note: in expansion of macro '__MAP5'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                                      ^
>> include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP6'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
>> include/linux/compat.h:45:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
     ^
   fs/notify/fanotify/fanotify_user.c:913:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE6'
    COMPAT_SYSCALL_DEFINE6(fanotify_mark,
    ^
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/uapi/linux/fanotify.h:4,
                    from include/linux/fanotify.h:4,
                    from fs/notify/fanotify/fanotify_user.c:1:
   fs/notify/fanotify/fanotify_user.c:915:5: error: expected expression before '__u32'
        __u32, mask0, __u32, mask1, int, dfd,
        ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:41:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
                              ^
>> include/linux/syscalls.h:42:35: note: in expansion of macro '__MAP4'
    #define __MAP5(m,t,a,...) m(t,a), __MAP4(m,__VA_ARGS__)
                                      ^
>> include/linux/syscalls.h:43:35: note: in expansion of macro '__MAP5'
    #define __MAP6(m,t,a,...) m(t,a), __MAP5(m,__VA_ARGS__)
                                      ^
--
   arch/s390/kernel/compat_linux.c: In function 'compat_SyS_s390_chown16':
   arch/s390/kernel/compat_linux.c:89:1: error: implicit declaration of function '__TYPE_IS_PTR' [-Werror=implicit-function-declaration]
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/s390/kernel/compat_linux.c:17:
   arch/s390/kernel/compat_linux.c:89:38: error: expected expression before 'const'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
                                         ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:40:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                              ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from arch/s390/include/asm/elf.h:119:0,
                    from include/linux/elf.h:4,
                    from include/linux/module.h:15,
                    from arch/s390/kernel/compat_linux.c:31:
   arch/s390/kernel/compat_linux.c:89:38: error: expected expression before 'const'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
                                         ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/s390/kernel/compat_linux.c:17:
   arch/s390/kernel/compat_linux.c:90:10: error: expected expression before 'u16'
             u16, user, u16, group)
             ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:39:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
                              ^
>> include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from arch/s390/include/asm/elf.h:119:0,
                    from include/linux/elf.h:4,
                    from include/linux/module.h:15,
                    from arch/s390/kernel/compat_linux.c:31:
   arch/s390/kernel/compat_linux.c:90:10: error: expected expression before 'u16'
             u16, user, u16, group)
             ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
>> include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/s390/kernel/compat_linux.c:17:
   arch/s390/kernel/compat_linux.c:90:21: error: expected expression before 'u16'
             u16, user, u16, group)
                        ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:38:23: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP1(m,t,a) m(t,a)
                          ^
>> include/linux/syscalls.h:39:35: note: in expansion of macro '__MAP1'
    #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
                                      ^
>> include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from arch/s390/include/asm/elf.h:119:0,
                    from include/linux/elf.h:4,
                    from include/linux/module.h:15,
                    from arch/s390/kernel/compat_linux.c:31:
   arch/s390/kernel/compat_linux.c:90:21: error: expected expression before 'u16'
             u16, user, u16, group)
                        ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
>> include/linux/syscalls.h:39:35: note: in expansion of macro '__MAP1'
    #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
                                      ^
>> include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:89:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_chown16, const char __user *, filename,
    ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/s390/kernel/compat_linux.c:17:
   arch/s390/kernel/compat_linux.c: In function 'compat_SyS_s390_lchown16':
   arch/s390/kernel/compat_linux.c:95:39: error: expected expression before 'const'
    COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
                                          ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:40:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                              ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:95:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
    ^
   In file included from arch/s390/include/asm/elf.h:119:0,
                    from include/linux/elf.h:4,
                    from include/linux/module.h:15,
                    from arch/s390/kernel/compat_linux.c:31:
   arch/s390/kernel/compat_linux.c:95:39: error: expected expression before 'const'
    COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
                                          ^
   arch/s390/include/asm/compat.h:12:20: note: in definition of macro '__SC_DELOUSE'
     (t)(__TYPE_IS_PTR(t) ? ((v) & 0x7fffffff) : (v)); \
                       ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
>> include/linux/compat.h:54:23: note: in expansion of macro '__MAP'
      return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
                          ^
   include/linux/compat.h:39:2: note: in expansion of macro 'COMPAT_SYSCALL_DEFINEx'
     COMPAT_SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
     ^
   arch/s390/kernel/compat_linux.c:95:1: note: in expansion of macro 'COMPAT_SYSCALL_DEFINE3'
    COMPAT_SYSCALL_DEFINE3(s390_lchown16, const char __user *,
    ^
   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/s390/kernel/compat_linux.c:17:
   arch/s390/kernel/compat_linux.c:96:20: error: expected expression before 'u16'
             filename, u16, user, u16, group)
                       ^
   include/linux/compiler.h:464:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^
   include/linux/compiler.h:484:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^
   include/linux/bug.h:50:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^
   include/linux/bug.h:74:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
     ^
>> arch/s390/include/asm/compat.h:11:2: note: in expansion of macro 'BUILD_BUG_ON'
     BUILD_BUG_ON(sizeof(t) > 4 && !__TYPE_IS_PTR(t)); \
     ^
   include/linux/syscalls.h:39:27: note: in expansion of macro '__SC_DELOUSE'
    #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
                              ^
>> include/linux/syscalls.h:40:35: note: in expansion of macro '__MAP2'
    #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
                                      ^
   include/linux/syscalls.h:44:22: note: in expansion of macro '__MAP3'
    #define __MAP(n,...) __MAP##n(__VA_ARGS__)
                         ^
..

vim +11 arch/s390/kernel/compat_wrapper.c

1e4ec621 arch/s390/kernel/compat_wrapper.c Heiko Carstens 2014-03-29   5   */
1e4ec621 arch/s390/kernel/compat_wrapper.c Heiko Carstens 2014-03-29   6  
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27   7  #include <linux/syscalls.h>
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27   8  #include <linux/compat.h>
86d295e1 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27   9  #include "entry.h"
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  10  
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @11  COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  12  COMPAT_SYSCALL_WRAP2(link, const char __user *, oldname, const char __user *, newname);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  13  COMPAT_SYSCALL_WRAP1(unlink, const char __user *, pathname);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @14  COMPAT_SYSCALL_WRAP1(chdir, const char __user *, filename);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  15  COMPAT_SYSCALL_WRAP3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  16  COMPAT_SYSCALL_WRAP2(chmod, const char __user *, filename, umode_t, mode);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @17  COMPAT_SYSCALL_WRAP1(oldumount, char __user *, name);
b07edab2 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  18  COMPAT_SYSCALL_WRAP2(access, const char __user *, filename, int, mode);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @19  COMPAT_SYSCALL_WRAP2(rename, const char __user *, oldname, const char __user *, newname);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @20  COMPAT_SYSCALL_WRAP2(mkdir, const char __user *, pathname, umode_t, mode);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  21  COMPAT_SYSCALL_WRAP1(rmdir, const char __user *, pathname);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @22  COMPAT_SYSCALL_WRAP1(pipe, int __user *, fildes);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @23  COMPAT_SYSCALL_WRAP1(brk, unsigned long, brk);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  24  COMPAT_SYSCALL_WRAP2(signal, int, sig, __sighandler_t, handler);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  25  COMPAT_SYSCALL_WRAP1(acct, const char __user *, name);
473a0657 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  26  COMPAT_SYSCALL_WRAP2(umount, char __user *, name, int, flags);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  27  COMPAT_SYSCALL_WRAP1(chroot, const char __user *, filename);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  28  COMPAT_SYSCALL_WRAP3(sigsuspend, int, unused1, int, unused2, old_sigset_t, mask);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  29  COMPAT_SYSCALL_WRAP2(sethostname, char __user *, name, int, len);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  30  COMPAT_SYSCALL_WRAP2(symlink, const char __user *, old, const char __user *, new);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  31  COMPAT_SYSCALL_WRAP3(readlink, const char __user *, path, char __user *, buf, int, bufsiz);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  32  COMPAT_SYSCALL_WRAP1(uselib, const char __user *, library);
be06fbf8 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  33  COMPAT_SYSCALL_WRAP2(swapon, const char __user *, specialfile, int, swap_flags);
c355ce18 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  34  COMPAT_SYSCALL_WRAP4(reboot, int, magic1, int, magic2, unsigned int, cmd, void __user *, arg);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  35  COMPAT_SYSCALL_WRAP2(munmap, unsigned long, addr, size_t, len);
c355ce18 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @36  COMPAT_SYSCALL_WRAP3(syslog, int, type, char __user *, buf, int, len);
c355ce18 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  37  COMPAT_SYSCALL_WRAP1(swapoff, const char __user *, specialfile);
c355ce18 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @38  COMPAT_SYSCALL_WRAP2(setdomainname, char __user *, name, int, len);
c355ce18 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @39  COMPAT_SYSCALL_WRAP1(newuname, struct new_utsname __user *, name);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  40  COMPAT_SYSCALL_WRAP3(mprotect, unsigned long, start, size_t, len, unsigned long, prot);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @41  COMPAT_SYSCALL_WRAP3(init_module, void __user *, umod, unsigned long, len, const char __user *, uargs);
86d295e1 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  42  COMPAT_SYSCALL_WRAP2(delete_module, const char __user *, name_user, unsigned int, flags);
86d295e1 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  43  COMPAT_SYSCALL_WRAP4(quotactl, unsigned int, cmd, const char __user *, special, qid_t, id, void __user *, addr);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  44  COMPAT_SYSCALL_WRAP2(bdflush, int, func, long, data);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  45  COMPAT_SYSCALL_WRAP3(sysfs, int, option, unsigned long, arg1, unsigned long, arg2);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  46  COMPAT_SYSCALL_WRAP5(llseek, unsigned int, fd, unsigned long, high, unsigned long, low, loff_t __user *, result, unsigned int, whence);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @47  COMPAT_SYSCALL_WRAP3(msync, unsigned long, start, size_t, len, int, flags);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  48  COMPAT_SYSCALL_WRAP2(mlock, unsigned long, start, size_t, len);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  49  COMPAT_SYSCALL_WRAP2(munlock, unsigned long, start, size_t, len);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @50  COMPAT_SYSCALL_WRAP2(sched_setparam, pid_t, pid, struct sched_param __user *, param);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  51  COMPAT_SYSCALL_WRAP2(sched_getparam, pid_t, pid, struct sched_param __user *, param);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  52  COMPAT_SYSCALL_WRAP3(sched_setscheduler, pid_t, pid, int, policy, struct sched_param __user *, param);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  53  COMPAT_SYSCALL_WRAP5(mremap, unsigned long, addr, unsigned long, old_len, unsigned long, new_len, unsigned long, flags, unsigned long, new_addr);
0ebe3eec arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @54  COMPAT_SYSCALL_WRAP3(poll, struct pollfd __user *, ufds, unsigned int, nfds, int, timeout);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  55  COMPAT_SYSCALL_WRAP5(prctl, int, option, unsigned long, arg2, unsigned long, arg3, unsigned long, arg4, unsigned long, arg5);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  56  COMPAT_SYSCALL_WRAP2(getcwd, char __user *, buf, unsigned long, size);
0ebe3eec arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27 @57  COMPAT_SYSCALL_WRAP2(capget, cap_user_header_t, header, cap_user_data_t, dataptr);
0ebe3eec arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-27  58  COMPAT_SYSCALL_WRAP2(capset, cap_user_header_t, header, const cap_user_data_t, data);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @59  COMPAT_SYSCALL_WRAP3(lchown, const char __user *, filename, uid_t, user, gid_t, group);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @60  COMPAT_SYSCALL_WRAP2(getgroups, int, gidsetsize, gid_t __user *, grouplist);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  61  COMPAT_SYSCALL_WRAP2(setgroups, int, gidsetsize, gid_t __user *, grouplist);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @62  COMPAT_SYSCALL_WRAP3(getresuid, uid_t __user *, ruid, uid_t __user *, euid, uid_t __user *, suid);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @63  COMPAT_SYSCALL_WRAP3(getresgid, gid_t __user *, rgid, gid_t __user *, egid, gid_t __user *, sgid);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  64  COMPAT_SYSCALL_WRAP3(chown, const char __user *, filename, uid_t, user, gid_t, group);
24e4c2aa arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  65  COMPAT_SYSCALL_WRAP2(pivot_root, const char __user *, new_root, const char __user *, put_old);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  66  COMPAT_SYSCALL_WRAP3(mincore, unsigned long, start, size_t, len, unsigned char __user *, vec);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  67  COMPAT_SYSCALL_WRAP3(madvise, unsigned long, start, size_t, len, int, behavior);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  68  COMPAT_SYSCALL_WRAP5(setxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  69  COMPAT_SYSCALL_WRAP5(lsetxattr, const char __user *, path, const char __user *, name, const void __user *, value, size_t, size, int, flags);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  70  COMPAT_SYSCALL_WRAP5(fsetxattr, int, fd, const char __user *, name, const void __user *, value, size_t, size, int, flags);
18421166 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  71  COMPAT_SYSCALL_WRAP3(getdents64, unsigned int, fd, struct linux_dirent64 __user *, dirent, unsigned int, count);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  72  COMPAT_SYSCALL_WRAP4(getxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  73  COMPAT_SYSCALL_WRAP4(lgetxattr, const char __user *, path, const char __user *, name, void __user *, value, size_t, size);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  74  COMPAT_SYSCALL_WRAP4(fgetxattr, int, fd, const char __user *, name, void __user *, value, size_t, size);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  75  COMPAT_SYSCALL_WRAP3(listxattr, const char __user *, path, char __user *, list, size_t, size);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  76  COMPAT_SYSCALL_WRAP3(llistxattr, const char __user *, path, char __user *, list, size_t, size);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  77  COMPAT_SYSCALL_WRAP3(flistxattr, int, fd, char __user *, list, size_t, size);
18421166 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  78  COMPAT_SYSCALL_WRAP2(removexattr, const char __user *, path, const char __user *, name);
18421166 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  79  COMPAT_SYSCALL_WRAP2(lremovexattr, const char __user *, path, const char __user *, name);
18421166 arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  80  COMPAT_SYSCALL_WRAP2(fremovexattr, int, fd, const char __user *, name);
9c4d62fa arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28 @81  COMPAT_SYSCALL_WRAP1(set_tid_address, int __user *, tidptr);
9c4d62fa arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  82  COMPAT_SYSCALL_WRAP4(epoll_ctl, int, epfd, int, op, int, fd, struct epoll_event __user *, event);
9c4d62fa arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  83  COMPAT_SYSCALL_WRAP4(epoll_wait, int, epfd, struct epoll_event __user *, events, int, maxevents, int, timeout);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01 @84  COMPAT_SYSCALL_WRAP1(io_destroy, aio_context_t, ctx);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  85  COMPAT_SYSCALL_WRAP3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb, struct io_event __user *, result);
9c4d62fa arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-02-28  86  COMPAT_SYSCALL_WRAP1(mq_unlink, const char __user *, name);
ab4f8bba arch/s390/kernel/compat_wrap.c    Heiko Carstens 2014-03-01  87  COMPAT_SYSCALL_WRAP5(add_key, const char __user *, tp, const char __user *, dsc, const void __user *, pld, size_t, len, key_serial_t, id);

:::::: The code at line 11 was first introduced by commit
:::::: b07edab23c7f93db0e7ab09bd7f5eddc421f6e8c s390/compat: convert system call wrappers to C part 01

:::::: TO: Heiko Carstens <heiko.carstens@de.ibm.com>
:::::: CC: Heiko Carstens <heiko.carstens@de.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39393 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/ec98ea50/attachment-0001.obj>
