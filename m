From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 20 Oct 2011 13:02:24 +0530
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
In-Reply-To: <CALQsFOJ+kYQ9iJfAPhcHtcWwA9A-5TFbUe+oyiTWrar=ZSN1_g@mail.gmail.com>
References: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
	<CAK5ve-LetP_jUyi22T0QhPkHgNqjFBuzuMa5+VnEfWvzFpy3Wg@mail.gmail.com>
	<CALQsFO+iuraeVVDZLWL5JUibNE2a-WC3ksGj3PV=tPWfuhJX9A@mail.gmail.com>
	<CALQsFOJ+kYQ9iJfAPhcHtcWwA9A-5TFbUe+oyiTWrar=ZSN1_g@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328693B98@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Oct 20, 2011 at 12:46:40, David Yang wrote:
> After lots of fails,once time I got the failure log from the serial console:
> 
> Unable to handle kernel paging request at virtual address e3500001
> pgd = d3b4c000
> [e3500001] *pgd=00000000
> Internal error: Oops: 5 [#1]
> last sysfs file:
> Modules linked in:
> CPU: 0    Tainted: G        W    (2.6.38.7-gb206aa6-dirty #77)
> PC is at futex_wake+0xd0/0x104
> LR is at futex_wake+0x50/0x104
> pc : [<c00682fc>]    lr : [<c006827c>]    psr: a0000013
> sp : d3073ea8  ip : d3073e88  fp : 40b9d6a4
> r10: 00000000  r9 : 00000001  r8 : c0914b88
> r7 : 00000000  r6 : ffffffff  r5 : 00000001  r4 : e34ffff5
> r3 : 0005d000  r2 : e594301c  r1 : 0e327082  r0 : c003fc24
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c53c7d  Table: 93b4c059  DAC: 00000015
> Process rsyslogd (pid: 587, stack limit = 0xd30722e8)
> Stack: (0xd3073ea8 to 0xd3074000)
> 3ea0:                   0005dab8 0005d000 d30a4c00 00000ab8 00000001 00000002
> 3ec0: 0005dab8 00000000 00000001 c0069854 00000021 40b9cbfc d3b047f0 00000021
> 3ee0: 00000021 00000000 fffffffa 00000245 00000000 d3b04d2c 00000000 0000002e
> 3f00: 00000000 d3b04d2c 00000000 00000000 d3802300 000000d0 c0914614 d3b04ba0
> 3f20: 00000002 d3be9a80 d30090c0 00000002 d30090c4 00000001 00000000 00000081
> 3f40: 0005dab8 c0032844 00000001 00000000 40b9d6a4 c006a0e8 00000002 00000000
> 3f60: ffffffff d30721b0 00000100 00000000 40b9c778 d3073fb0 40b9c6f8 0005e6a8
> 3f80: 000000ad 00000002 0005dab8 00000002 000000f0 c0032844 d3072000 00000000
> 3fa0: 40b9d6a4 c0032680 00000002 0005dab8 0005dab8 00000081 00000001 00000000
> 3fc0: 00000002 0005dab8 00000002 000000f0 0003d8c0 0004043c 00040418 40b9d6a4
> 3fe0: 00000000 40b9cab8 4010ae24 4010ae4c 20000010 0005dab8 93ffe821 93ffec21
> [<c00682fc>] (futex_wake+0xd0/0x104) from [<c0069854>] (do_futex+0xb8/0x804)
> [<c0069854>] (do_futex+0xb8/0x804) from [<c006a0e8>] (sys_futex+0x148/0x160)
> [<c006a0e8>] (sys_futex+0x148/0x160) from [<c0032680>]
> (ret_fast_syscall+0x0/0x30)
> Code: e2877001 ebffffb4 e1570005 aa000007 (e594300c)
> ---[ end trace 887204a6d10c91ae ]---

Is printk time showing "0" timestamps for this Kernel ?

Regards
Afzal
