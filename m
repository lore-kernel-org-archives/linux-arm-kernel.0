From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Thu, 1 Oct 2015 13:02:46 +0530
Subject: Undefined instruction error on Cortex A57 (aarch64) in init process
Message-ID: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In android system, after system is running for long time say 10 hour,
some time i am hitting below
traces:

 init[1]: undefined instruction: pc=0000000000401624
Code: 1a9f00c2 aa1703e0 2a1603e1 9400e1bf (6b1f001f)
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

CPU: 0 PID: 1 Comm: init Tainted: G           O 3.10.67-g978f332 #15
Call trace:
[<ffffffc000089ccc>] dump_backtrace+0x0/0xf4
[<ffffffc00008a05c>] show_stack+0x10/0x1c
[<ffffffc0003738c0>] dump_stack+0x1c/0x28
[<ffffffc0000aa84c>] panic+0xf8/0x118
[<ffffffc0000af790>] find_new_reaper+0x98/0x154
[<ffffffc0000b0490>] forget_original_parent+0x40/0x1cc
[<ffffffc0000b0630>] exit_notify+0x14/0x16c
[<ffffffc0000b0a4c>] do_exit+0x2c4/0x3ec
[<ffffffc0000b1814>] do_group_exit+0xe8/0xec
[<ffffffc0000c1b8c>] get_signal_to_deliver+0x310/0x3a8
[<ffffffc000089648>] do_signal+0x160/0x180

The objdump of binary around this address is :
 401610:       eb1f011f        cmp     x8, xzr
 401614:       1a9f00c2        csel    w2, w6, wzr, eq
               bootchart_count = 0;
           }
       }
endif

       nr = poll(ufds, fd_count, timeout);
 401618:       aa1703e0        mov     x0, x23
 40161c:       2a1603e1        mov     w1, w22
 401620:       9400e1df        bl      439d9c <poll>
       if (nr <= 0)
 401624:       6b1f001f        cmp     w0, wzr
 401628:       54fffccd        b.le    4015c0 <main+0x558>
           continue;

       for (i = 0; i < fd_count; i++) {
 40162c:       34fffcb6        cbz     w22, 4015c0 <main+0x558>
 401630:       510006c9        sub     w9, w22, #0x1
 401634:       aa1703f3        mov     x19, x23
 401638:       9100052a        add     x10, x9, #0x1
 40163c:       8b0a0ef4        add     x20, x23, x10, lsl #3

Could any one please point me to what could be the problem here ? Or
how further i can approach to debug this further.

-Pankaj Kumar
