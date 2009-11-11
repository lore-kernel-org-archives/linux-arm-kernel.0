From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 11 Nov 2009 15:55:02 +0100
Subject: kirkwood / openrd: umount problem using mdev (busybox)
In-Reply-To: <200911061559.47922.dk-arm-linux@gmx.de>
References: <200911061559.47922.dk-arm-linux@gmx.de>
Message-ID: <200911111555.02938.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

> Hi all,
> 
> I've encountered a new problem with regards to busybox mdev while umounting a usb pendrive:
> I'm using kernel
> sh-3.2# uname -a
> Linux DB88FXX81 2.6.32-rc4 #2 PREEMPT Thu Nov 5 13:41:41 CET 2009 armv5tel GNU/Linux
> sh-3.2#
> 
> 
> Mounting and umounting manually works like a charm without any problems. But if I disconnected a
> mounted pendrive and wants mdev to umount it on a remove event the umount call hangs until I get a
> message from my kernel (see below).
>

This problem also doesn't exist with marvell stock 2.6.22.18 kernel.
So I would assume it is no busybox problem.
It looks like another kernel problem with current mainline kernel?

mounting / umounting with busybox mdev works reliable and as expected.

Dieter
 
> 
> 
> A strace of the umount call gives:
> execve("/bin/umount", ["umount", "-f", "-l", "/dev/sda1"], [/* 14 vars */]) = 0
> brk(0)                                  = 0xf5000
> uname({sys="Linux", node="DB88FXX81", ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001d000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
> open("/lib/tls/v5l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/v5l/fast-mult/half", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/tls/v5l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/v5l/fast-mult", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/tls/v5l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/v5l/half", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/tls/v5l/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/v5l", 0xbed722f8)      = -1 ENOENT (No such file or directory)
> open("/lib/tls/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/fast-mult/half", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/tls/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/fast-mult", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/tls/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/tls/half", 0xbed722f8)     = -1 ENOENT (No such file or directory)
> open("/lib/tls/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
> stat64("/lib/tls", 0xbed722f8)          = -1 ENOENT (No such file or directory)
> open("/lib/v5l/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/v5l/fast-mult/half", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/v5l/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/v5l/fast-mult", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/v5l/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/v5l/half", 0xbed722f8)     = -1 ENOENT (No such file or directory)
> open("/lib/v5l/libm.so.6", O_RDONLY)    = -1 ENOENT (No such file or directory)
> stat64("/lib/v5l", 0xbed722f8)          = -1 ENOENT (No such file or directory)
> open("/lib/fast-mult/half/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/fast-mult/half", 0xbed722f8) = -1 ENOENT (No such file or directory)
> open("/lib/fast-mult/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/lib/fast-mult", 0xbed722f8)    = -1 ENOENT (No such file or directory)
> open("/lib/half/libm.so.6", O_RDONLY)   = -1 ENOENT (No such file or directory)
> stat64("/lib/half", 0xbed722f8)         = -1 ENOENT (No such file or directory)
> open("/lib/libm.so.6", O_RDONLY)        = 4
> read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0342\0\0004\0\0\0"..., 512) = 512
> fstat64(4, {st_mode=S_IFREG|0755, st_size=693352, ...}) = 0
> mmap2(NULL, 712856, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x40026000
> mprotect(0x400cc000, 28672, PROT_NONE)  = 0
> mmap2(0x400d3000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0xa5) = 0x400d3000
> close(4)                                = 0
> open("/lib/libgcc_s.so.1", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/v5l/fast-mult/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/v5l/fast-mult/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/v5l/fast-mult/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/v5l/fast-mult", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/v5l/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/v5l/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/v5l/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/v5l", 0xbed722e0)  = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/fast-mult/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/fast-mult/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/fast-mult/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/fast-mult", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/tls/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/tls", 0xbed722e0)      = -1 ENOENT (No such file or directory)
> open("/usr/lib/v5l/fast-mult/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/v5l/fast-mult/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/v5l/fast-mult/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/v5l/fast-mult", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/v5l/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/v5l/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/v5l/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/v5l", 0xbed722e0)      = -1 ENOENT (No such file or directory)
> open("/usr/lib/fast-mult/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/fast-mult/half", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/fast-mult/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/fast-mult", 0xbed722e0) = -1 ENOENT (No such file or directory)
> open("/usr/lib/half/libgcc_s.so.1", O_RDONLY) = -1 ENOENT (No such file or directory)
> stat64("/usr/lib/half", 0xbed722e0)     = -1 ENOENT (No such file or directory)
> open("/usr/lib/libgcc_s.so.1", O_RDONLY) = 4
> read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\304\"\0\0004\0\0\0"..., 512) = 512
> fstat64(4, {st_mode=S_IFREG|0644, st_size=65824, ...}) = 0
> mmap2(NULL, 78540, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x400d5000
> mprotect(0x400e1000, 28672, PROT_NONE)  = 0
> mmap2(0x400e8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0xb) = 0x400e8000
> close(4)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 4
> read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\340J\1\0004\0\0\0"..., 512) = 512
> fstat64(4, {st_mode=S_IFREG|0755, st_size=1249460, ...}) = 0
> mmap2(NULL, 1237404, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4, 0) = 0x400e9000
> mprotect(0x4020b000, 28672, PROT_NONE)  = 0
> mmap2(0x40212000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x121) = 0x40212000
> mmap2(0x40215000, 8604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40215000
> close(4)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001e000
> set_tls(0x4001e720, 0x400256f4, 0x4001edf8, 0x40025058, 0x40) = 0
> mprotect(0x40212000, 8192, PROT_READ)   = 0
> mprotect(0x400d3000, 4096, PROT_READ)   = 0
> getpid()                                = 562
> getuid32()                              = 0
> brk(0)                                  = 0xf5000
> brk(0x117000)                           = 0x117000
> open("/proc/mounts", O_RDONLY)          = 4
> fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001f000
> read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 655
> read(4, "", 1024)                       = 0
> close(4)                                = 0
> munmap(0x4001f000, 4096)                = 0
> lstat64("/dev", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=2880, ...}) = 0
> lstat64("/dev/sda1", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 1), ...}) = 0
> umount("/mnt/usbdisk", 0
> 
> And after that the process hangs:
> 
> sh-3.2# ps
>   PID USER       VSZ STAT COMMAND
>     1 root      3256 S    init
>     2 root         0 SW   [kthreadd]
>     3 root         0 SW   [ksoftirqd/0]
>     4 root         0 SW   [watchdog/0]
>     5 root         0 SW   [events/0]
>     6 root         0 SW   [khelper]
>     9 root         0 SW   [async/mgr]
>   133 root         0 SW   [sync_supers]
>   135 root         0 SW   [bdi-default]
>   137 root         0 SW   [kblockd/0]
>   143 root         0 SW   [ata/0]
>   144 root         0 SW   [ata_aux]
>   152 root         0 SW   [khubd]
>   155 root         0 SW   [kseriod]
>   158 root         0 SW   [kmmcd]
>   178 root         0 SW   [rpciod/0]
>   186 root         0 SW   [khungtaskd]
>   187 root         0 SW   [kswapd0]
>   236 root         0 SW   [aio/0]
>   244 root         0 SW   [nfsiod]
>   250 root         0 SW   [crypto/0]
>   387 root         0 SW   [scsi_eh_0]
>   390 root         0 SW   [scsi_eh_1]
>   397 root         0 SW   [mtdblockd]
>   411 root         0 SW   [orion_spi]
>   494 root         0 SW   [usbhid_resumer]
>   515 root      2280 S    /bin/sh /sbin/mini_httpd_wrapper
>   516 root      2644 S    -/bin/sh
>   519 root      2176 S    /sbin/mini_httpd -D -d /var/www -u root -c **.cgi -i
>   527 root         0 SW   [scsi_eh_2]
>   550 root      3264 S    /sbin/mdev block
>   554 root      2604 S    /bin/sh /sbin/mdev_mount_usbdisk.sh
>   561 root      1836 S    strace umount -f -l /dev/sda1
>   562 root      3260 D    umount -f -l /dev/sda1
>   564 root      3260 R    ps
> sh-3.2#
> 
> After a while I get this from my kernel every now and then:
> 
> sh-3.2# INFO: task umount:562 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> umount        D c03467c0     0   562    561 0x00000100
> [<c03467c0>] (schedule+0x360/0x3f0) from [<c00d18f0>] (bdi_sched_wait+0xc/0x18)
> [<c00d18f0>] (bdi_sched_wait+0xc/0x18) from [<c03472e4>] (__wait_on_bit+0x60/0xac)
> [<c03472e4>] (__wait_on_bit+0x60/0xac) from [<c03473a4>] (out_of_line_wait_on_bit+0x74/0x80)
> [<c03473a4>] (out_of_line_wait_on_bit+0x74/0x80) from [<c00d1984>] (sync_inodes_sb+0x88/0x17c)
> [<c00d1984>] (sync_inodes_sb+0x88/0x17c) from [<c00d5c38>] (__sync_filesystem+0x30/0x6c)
> [<c00d5c38>] (__sync_filesystem+0x30/0x6c) from [<c00b6248>] (generic_shutdown_super+0x2c/0x130)
> [<c00b6248>] (generic_shutdown_super+0x2c/0x130) from [<c00b6368>] (kill_block_super+0x1c/0x38)
> [<c00b6368>] (kill_block_super+0x1c/0x38) from [<c00b66c0>] (deactivate_super+0x68/0x8c)
> [<c00b66c0>] (deactivate_super+0x68/0x8c) from [<c00cd734>] (sys_umount+0x2c8/0x2fc)
> [<c00cd734>] (sys_umount+0x2c8/0x2fc) from [<c0026b1c>] (__sys_trace_return+0x0/0x24)
> 
> Any help would be welcome!
> 
> Many thanks,
> Dieter
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
