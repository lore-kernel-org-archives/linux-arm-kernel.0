From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 20 Oct 2011 20:02:25 +0800
Subject: Question about: linux-linaro-2.6.38.7 booting the ubuntu 10.10
	filesystem
In-Reply-To: <CALQsFOJHiLVskuhGe-OsK8PdUxuR8Lv9idJcmf8vZEumenBUnw@mail.gmail.com>
References: <CALQsFO+o+zQJZiksb+2fW8b_kdTv6tqhjxYU6owv=hMhbk=92A@mail.gmail.com>
	<CAK5ve-LetP_jUyi22T0QhPkHgNqjFBuzuMa5+VnEfWvzFpy3Wg@mail.gmail.com>
	<CALQsFO+iuraeVVDZLWL5JUibNE2a-WC3ksGj3PV=tPWfuhJX9A@mail.gmail.com>
	<CALQsFOJ+kYQ9iJfAPhcHtcWwA9A-5TFbUe+oyiTWrar=ZSN1_g@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328693B98@dbde02.ent.ti.com>
	<CALQsFOJHiLVskuhGe-OsK8PdUxuR8Lv9idJcmf8vZEumenBUnw@mail.gmail.com>
Message-ID: <CALQsFOLs-Jz5-yPGOZkpqumgUUq8V90mCrEJ1EBPvXSwMbVM3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

another log when booting ubuntu10.10:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = ebbf8000
[00000000] *pgd=abbea831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
last sysfs file: /sys/devices/virtual/vc/vcsa7/uevent
Modules linked in:
CPU: 0    Tainted: G        W    (2.6.38.7-g23c6b13-dirty #1)
PC is at futex_wake+0xdc/0x110
LR is at futex_wake+0x5c/0x110
pc : [<c0060b74>]    lr : [<c0060af4>]    psr: 80000013
sp : ebb5de78  ip : ebb5de78  fp : ebb5deac
r10: 00000001  r9 : ebb5c000  r8 : c0390568
r7 : 00000000  r6 : ffffffff  r5 : 00000001  r4 : fffffff4
r3 : 00030000  r2 : 00000000  r1 : 3df9d500  r0 : c0923bd4
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: abbf8059  DAC: 00000015
Process gconf-sanity-ch (pid: 3255, stack limit = 0xebb5c2e8)
Stack: (0xebb5de78 to 0xebb5e000)
de60:                                                       00000000 00030000
de80: eb999048 00000a18 c009e3e0 00000001 00000002 00030a18 00000000 c002cc88
dea0: ebb5df44 ebb5deb0 c0062154 c0060aa4 00000000 00000000 00000000 00000000
dec0: eb844ac0 c009bfd8 00000000 00000000 00000000 00000000 ebb5df04 ebb5dee8
dee0: 00000001 c009bf04 00000001 00000001 ebb5df70 c02aa980 ea4fc268 ea452410
df00: 00000000 00000000 00000000 00000000 41651ba0 00000001 ea4fc268 00000001
df20: 00000000 00000081 000000f0 c002cc88 ebb5c000 00030a18 ebb5dfa4 ebb5df48
df40: c0062a0c c00620a0 00000002 00000000 ffffffff 00000001 ebb5c000 00000001
df60: ebb5dfa4 ebb5df70 c009f128 c009f7b8 00000000 00000000 ebb5dfa4 00000002
df80: 00030a18 00000000 000000f0 c002cc88 ebb5c000 00000000 00000000 ebb5dfa8
dfa0: c002cac0 c00628c8 00000002 00030a18 00030a18 00000081 00000001 00000000
dfc0: 00000002 00030a18 00000000 000000f0 00030a10 000002c4 00000000 000002f4
dfe0: 000000f0 41651b70 4002c477 40031fc6 20000030 00030a18 00000000 00000000
Backtrace:
[<c0060a98>] (futex_wake+0x0/0x110) from [<c0062154>] (do_futex+0xc0/0x828)
 r8:c002cc88 r7:00000000 r6:00030a18 r5:00000002 r4:00000001
[<c0062094>] (do_futex+0x0/0x828) from [<c0062a0c>] (sys_futex+0x150/0x168)
[<c00628bc>] (sys_futex+0x0/0x168) from [<c002cac0>] (ret_fast_syscall+0x0/0x30)
Code: e2877001 ebffffaf e1570005 aa000007 (e594300c)



the PC stopped at futex_wake() again!


Best Regards,
David

On 10/20/11, David Yang <david.yangshuai@gmail.com> wrote:
> hi,Afzal
>
>   Thanks for your reply!
>
>   I don't know which CONFIG of kernel affects the timestamps.
>
>  AND NOW:
>   when I stop the rsyslogd daemon when booting ubuntu9.10 console
> filesytem.I can get the login prompt now! I will try ubuntu10.10
> Desktop later.
>
>
>
> Best Regards,
> David
>
>
> On 10/20/11, Mohammed, Afzal <afzal@ti.com> wrote:
>> Hi David,
>>
>> On Thu, Oct 20, 2011 at 12:46:40, David Yang wrote:
>>> After lots of fails,once time I got the failure log from the serial
>>> console:
>>>
>>> Unable to handle kernel paging request at virtual address e3500001
>>> pgd = d3b4c000
>>> [e3500001] *pgd=00000000
>>> Internal error: Oops: 5 [#1]
>>> last sysfs file:
>>> Modules linked in:
>>> CPU: 0    Tainted: G        W    (2.6.38.7-gb206aa6-dirty #77)
>>> PC is at futex_wake+0xd0/0x104
>>> LR is at futex_wake+0x50/0x104
>>> pc : [<c00682fc>]    lr : [<c006827c>]    psr: a0000013
>>> sp : d3073ea8  ip : d3073e88  fp : 40b9d6a4
>>> r10: 00000000  r9 : 00000001  r8 : c0914b88
>>> r7 : 00000000  r6 : ffffffff  r5 : 00000001  r4 : e34ffff5
>>> r3 : 0005d000  r2 : e594301c  r1 : 0e327082  r0 : c003fc24
>>> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>> Control: 10c53c7d  Table: 93b4c059  DAC: 00000015
>>> Process rsyslogd (pid: 587, stack limit = 0xd30722e8)
>>> Stack: (0xd3073ea8 to 0xd3074000)
>>> 3ea0:                   0005dab8 0005d000 d30a4c00 00000ab8 00000001
>>> 00000002
>>> 3ec0: 0005dab8 00000000 00000001 c0069854 00000021 40b9cbfc d3b047f0
>>> 00000021
>>> 3ee0: 00000021 00000000 fffffffa 00000245 00000000 d3b04d2c 00000000
>>> 0000002e
>>> 3f00: 00000000 d3b04d2c 00000000 00000000 d3802300 000000d0 c0914614
>>> d3b04ba0
>>> 3f20: 00000002 d3be9a80 d30090c0 00000002 d30090c4 00000001 00000000
>>> 00000081
>>> 3f40: 0005dab8 c0032844 00000001 00000000 40b9d6a4 c006a0e8 00000002
>>> 00000000
>>> 3f60: ffffffff d30721b0 00000100 00000000 40b9c778 d3073fb0 40b9c6f8
>>> 0005e6a8
>>> 3f80: 000000ad 00000002 0005dab8 00000002 000000f0 c0032844 d3072000
>>> 00000000
>>> 3fa0: 40b9d6a4 c0032680 00000002 0005dab8 0005dab8 00000081 00000001
>>> 00000000
>>> 3fc0: 00000002 0005dab8 00000002 000000f0 0003d8c0 0004043c 00040418
>>> 40b9d6a4
>>> 3fe0: 00000000 40b9cab8 4010ae24 4010ae4c 20000010 0005dab8 93ffe821
>>> 93ffec21
>>> [<c00682fc>] (futex_wake+0xd0/0x104) from [<c0069854>]
>>> (do_futex+0xb8/0x804)
>>> [<c0069854>] (do_futex+0xb8/0x804) from [<c006a0e8>]
>>> (sys_futex+0x148/0x160)
>>> [<c006a0e8>] (sys_futex+0x148/0x160) from [<c0032680>]
>>> (ret_fast_syscall+0x0/0x30)
>>> Code: e2877001 ebffffb4 e1570005 aa000007 (e594300c)
>>> ---[ end trace 887204a6d10c91ae ]---
>>
>> Is printk time showing "0" timestamps for this Kernel ?
>>
>> Regards
>> Afzal
>>
>
