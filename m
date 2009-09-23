From: viriketo@gmail.com (=?UTF-8?Q?Llu=C3=ADs_Batlle?=)
Date: Wed, 23 Sep 2009 10:43:56 +0200
Subject: Problem in USB on the Sheevaplug, 2.6.31
Message-ID: <45219fb00909230143h38db71e7l7c16b4a59ec1b152@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

after using a USB storage device (a Kingston DataTraveler 8GB flash
stick) in the sheevaplug for some hours, at one point the device
stopped working until I replugged it in.

The system kept stable, while all this happened.

Here comes the 'dmesg' part:

EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with writeback data mode.
#------------ some hours passed ----------
usb 1-1: reset high speed USB device using orion-ehci and address 2
------------[ cut here ]------------
WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
Modules linked in: sg
[<c002f85c>] (unwind_backtrace+0x0/0xdc) from [<c003ecb0>]
(warn_slowpath_common+0x4c/0x80)
[<c003ecb0>] (warn_slowpath_common+0x4c/0x80) from [<c002b974>]
(cpu_idle+0x74/0xbc)
[<c002b974>] (cpu_idle+0x74/0xbc) from [<c0008b04>] (start_kernel+0x270/0x2d4)
[<c0008b04>] (start_kernel+0x270/0x2d4) from [<00008034>] (0x8034)
---[ end trace 81d90711559dbd0e ]---
usb 1-1: reset high speed USB device using orion-ehci and address 2
usb 1-1: device descriptor read/64, error -110
usb 1-1: device descriptor read/64, error -32
usb 1-1: reset high speed USB device using orion-ehci and address 2
usb 1-1: device descriptor read/64, error -32
usb 1-1: device descriptor read/64, error -32
usb 1-1: reset high speed USB device using orion-ehci and address 2
usb 1-1: device not accepting address 2, error -32
usb 1-1: reset high speed USB device using orion-ehci and address 2
usb 1-1: device not accepting address 2, error -32
sd 0:0:0:0: [sda] Unhandled error code
sd 0:0:0:0: [sda] Result: hostbyte=0x07 driverbyte=0x00
end_request: I/O error, dev sda, sector 15466566
usb 1-1: USB disconnect, address 2
EXT3-fs error (device sda1): read_inode_bitmap: Cannot read inode
bitmap - block_group = 59, inode_bitmap = 1933313
EXT3-fs error (device sda1) in ext3_new_inode: IO failure
------------[ cut here ]------------
WARNING: at fs/buffer.c:1152 mark_buffer_dirty+0x34/0xe8()
Modules linked in: sg
[<c002f85c>] (unwind_backtrace+0x0/0xdc) from [<c003ecb0>]
(warn_slowpath_common+0x4c/0x80)
[<c003ecb0>] (warn_slowpath_common+0x4c/0x80) from [<c00d67d4>]
(mark_buffer_dirty+0x34/0xe8)
[<c00d67d4>] (mark_buffer_dirty+0x34/0xe8) from [<c010b3ac>]
(ext3_commit_super+0x4c/0x70)
[<c010b3ac>] (ext3_commit_super+0x4c/0x70) from [<c010c5a0>]
(ext3_handle_error+0x98/0xc4)
[<c010c5a0>] (ext3_handle_error+0x98/0xc4) from [<c010c634>]
(__ext3_std_error+0x68/0x74)
[<c010c634>] (__ext3_std_error+0x68/0x74) from [<c0102e60>]
(ext3_new_inode+0x898/0x91c)
[<c0102e60>] (ext3_new_inode+0x898/0x91c) from [<c0109898>]
(ext3_mkdir+0x8c/0x2cc)
[<c0109898>] (ext3_mkdir+0x8c/0x2cc) from [<c00bc5ac>] (vfs_mkdir+0x6c/0xc0)
[<c00bc5ac>] (vfs_mkdir+0x6c/0xc0) from [<c00be928>] (sys_mkdirat+0x84/0xd0)
[<c00be928>] (sys_mkdirat+0x84/0xd0) from [<c002a9c0>]
(ret_fast_syscall+0x0/0x2c)
---[ end trace 81d90711559dbd0f ]---
Aborting journal on device sda1.
journal commit I/O error
ext3_abort called.
EXT3-fs error (device sda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only

It's a vanilla kernel built with gcc 4.3.4 . If you need more
information, I can compile special versions of that kernel to get some
additional information.

Regards,
Llu?s.
