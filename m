From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 6 May 2010 21:35:13 +0900
Subject: Can't boot when THUMB-2 mode at 2.6.32.12
Message-ID: <j2q9c9fda241005060535u668dd4ccw328781b77685f6a3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm turn on the thumb-2 mode with "Use kernel mem{cpy,set}() for
{copy_to,clear}_user()"

Then I got the following message. Of course without
CONFIG_UACCESS_WITH_MEMCPY. it boots well"

Do you have any hints?

I used the cortex-A8 cpu.

Thank you,
Kyungmin Park

[    3.090000] Freeing init memory: 92K
[    3.100000] Internal error: Oops - undefined instruction: 0 [#1] PREEMPT
[    3.100000] last sysfs file:
[    3.100000] Modules linked in:
[    3.100000] CPU: 0    Not tainted  (2.6.32.12 #28)
[    3.100000] PC is at __copy_to_user_std+0x10/0x418
[    3.100000] LR is at 0x18e0
[    3.100000] pc : [<c00fd230>]    lr : [<000018e0>]    psr: 20000013
[    3.100000] sp : e7835cf8  ip : 000000de  fp : 00000000
[    3.100000] r10: 00000114  r9 : e718cc00  r8 : 00000013
[    3.100000] r7 : 00000114  r6 : 00000013  r5 : c036e100  r4 : e7835d74
[    3.100000] r3 : c0000018  r2 : 00000013  r1 : c0008114  r0 : e7277b80
[    3.100000] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kern
el
[    3.100000] Control: 50c5387d  Table: 30004019  DAC: 00000017
[    3.100000] Process swapper (pid: 1, stack limit = 0xe78342e8)
[    3.100000] Stack: (0xe7835cf8 to 0xe7836000)
[    3.100000] 5ce0:                                                       c0000
018 c004c021
[    3.100000] 5d00: 00000eec c036e100 00000000 00000eec e741ce24 00000114 00000
114 c004da15
[    3.100000] 5d20: 0000001f 00000000 00000001 c0328ae0 00000000 000de37c 00000
000 00000000
[    3.100000] 5d40: e7835e48 e7834000 e718cc60 00000000 00000000 00000000 00000
000 00000000
[    3.100000] 5d60: 00000001 e741cd50 e7835e08 00000001 00000001 00000000 00000
013 e7277b80
[    3.100000] 5d80: 00000000 00000013 00000000 e7835db8 e7835e88 e718cc00 00000
000 e7835e88
[    3.100000] 5da0: e7277b80 e7834000 c008d745 c0069347 00000114 00000000 00000
5f7 00000001
[    3.100000] 5dc0: 00000000 00000001 ffffffff e718cc00 00000000 00000000 00000
000 00000000
[    3.100000] 5de0: e7832000 c005ff6f 00000000 00000000 e7a58910 e7832000 c003d
285 e7835dfc
[    3.100000] 5e00: e7835dfc e7a58910 00000114 00000000 30080008 c036e3c0 c02f4
4d0 00000000
[    3.100000] 5e20: 00000013 c02f44d0 c0851a60 c02f454c 00000000 c02f44bc e7834
000 00000000
[    3.100000] 5e40: e7409d80 000000e0 e7277b80 00000013 e7409d80 00000013 e718c
c00 e7277b80
[    3.100000] 5e60: c00692e1 c0069aa5 e718cc00 e7277b80 bf000000 e7835e88 e733a
800 e733b940
[    3.100000] 5e80: 00000000 c006cf6f 00000114 00000000 00000114 000000e0 e71bb
380 c008d84b
[    3.100000] 5ea0: e7277b80 00000013 00000001 00000000 e7835f04 e733b900 00000
001 00000fc3
[    3.100000] 5ec0: 00000000 e7835f80 e7834000 c005a945 00000017 e7835f04 00000
000 00000001
[    3.100000] 5ee0: e7834000 00000000 e733a800 c006c37d 00000001 00000001 e7835
f04 e733a800
[    3.100000] 5f00: c030ca3c fffffff8 00000000 00000000 e7835f80 e7834000 c008d
745 c006c709
[    3.100000] 5f20: c027745c 00000000 e733a800 e733a802 e733a800 e7834000 c02f6
268 c02f62f0
[    3.100000] 5f40: e733a800 00000000 00000000 e7835f80 00000000 c006d6d7 c0277
45c 00000000
[    3.100000] 5f60: e7835f80 c02f6268 c027745c c02f62f0 00000000 00000000 00000
000 c0021e99
[    3.100000] 5f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000
000 00000000
[    3.100000] 5fa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000
000 00000000
[    3.100000] 5fc0: 00000000 00000000 e718c900 c0329180 00000000 00000000 00000
000 c001f36b
[    3.100000] 5fe0: e7801200 c001f3e9 c0329180 c00084c1 00000000 c0020655 fffff
fff fffffffe
[    3.100000] [<c00fd230>] (__copy_to_user_std+0x10/0x418) from [<c004c021>] (f
ile_read_actor+0x71/0xf4)
[    3.100000] [<c004c021>] (file_read_actor+0x71/0xf4) from [<c004da15>] (gener
ic_file_aio_read+0x2e1/0x4e0)
[    3.100000] [<c004da15>] (generic_file_aio_read+0x2e1/0x4e0) from [<c0069347>
] (do_sync_read+0x67/0x9c)
[    3.100000] [<c0069347>] (do_sync_read+0x67/0x9c) from [<c0069aa5>] (vfs_read
+0x65/0xd8)
[    3.100000] [<c0069aa5>] (vfs_read+0x65/0xd8) from [<c006cf6f>] (kernel_read+
0x33/0x5c)
[    3.100000] [<c006cf6f>] (kernel_read+0x33/0x5c) from [<c008d84b>] (load_elf_
binary+0x107/0xd08)
[    3.100000] [<c008d84b>] (load_elf_binary+0x107/0xd08) from [<c006c709>] (sea
rch_binary_handler+0xc5/0x214)
[    3.100000] [<c006c709>] (search_binary_handler+0xc5/0x214) from [<c006d6d7>]
 (do_execve+0x10f/0x1c8)
[    3.100000] [<c006d6d7>] (do_execve+0x10f/0x1c8) from [<c0021e99>] (kernel_ex
ecve+0x21/0x54)
[    3.100000] [<c0021e99>] (kernel_execve+0x21/0x54) from [<c001f36b>] (run_ini
t_process+0xf/0x14)
[    3.100000] [<c001f36b>] (run_init_process+0xf/0x14) from [<c001f3e9>] (init_
post+0x79/0xb8)
[    3.100000] [<c001f3e9>] (init_post+0x79/0xb8) from [<c00084c1>] (kernel_init
+0x95/0xc0)
[    3.100000] [<c00084c1>] (kernel_init+0x95/0xc0) from [<c0020655>] (kernel_th
read_exit+0x1/0x8)
[    3.100000] Code: 0300f04f 401de92d db7d3a04 0c03f010 (f000f891)
