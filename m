From: walsimou@walsimou.com (Gaye Abdoulaye Walsimou)
Date: Mon, 21 Dec 2009 16:07:16 +0100
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
References: <4B2E4A65.8070207@walsimou.com>	<200912211410.12014.jbe@pengutronix.de>
	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
Message-ID: <4B2F8F24.3030109@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

M P wrote:
> On Mon, Dec 21, 2009 at 1:10 PM, Juergen Beisert <jbe@pengutronix.de> wrote:
>   
>> On Sonntag, 20. Dezember 2009, Gaye Abdoulaye Walsimou wrote:
>>     
>>> Hello list,
>>> I have here a boot Oops (see below) with the latest git revision of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git,
>>> which does not happen with 2.6.32.
>>> Thanks in advance for comments.
>>> Regards
>>>       
>
> I have a patch in my git that related to that :
> http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a
>
> I need to push that to the list as soon as I rebase on 2.6.33.
>
> Michael
>
>   

This patch does not help with the issue reported here.
But it helps on another issue which occurs when I try to reboot the
board (under busybox):

# reboot
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system reboot
Unable to handle kernel NULL pointer dereference at virtual address 0000009d
pgd = c3b40000
[0000009d] *pgd=33b4c031, *pte=00000000, *ppte=00000000
Internal error: Oops: 13 [#1] PREEMPT
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.32 #75)
PC is at device_shutdown+0x68/0xac
LR is at kernel_restart_prepare+0x2c/0x3c
pc : [<c06a27b8>]    lr : [<c0582c78>]    psr: 60000013
sp : c3b61e40  ip : c3b61e60  fp : c3b61e5c
r10: 40023000  r9 : c3b60000  r8 : c055e124
r7 : 00000000  r6 : c081c67c  r5 : 0000008d  r4 : c081c67c
r3 : 00000000  r2 : c05568a8  r1 : c3802be0  r0 : c05568a8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: c000717f  Table: 33b40000  DAC: 00000015
Process init (pid: 816, stack limit = 0xc3b60270)
Stack: (0xc3b61e40 to 0xc3b62000)
1e40: 00000000 28121969 01234567 00000000 c3b61e6c c3b61e60 c0582c78
c06a2760
1e60: c3b61e84 c3b61e70 c0582cc8 c0582c5c fee1dead 28121969 c3b61fa4
c3b61e88
1e80: c0582dfc c0582cc4 00000011 00000011 c07d8a90 c38360c0 c38360f0
00000000
1ea0: 000baeb9 00000000 c07d8a90 ffffffff c381c000 00000002 c3b4ede0
c3819c40
1ec0: c3b61ef4 c3b61ed0 c058cad4 c056ad60 00000000 c0660aa8 c381c01c
c38360c0
1ee0: 00000015 c383624c c3b61f0c c3b61ef8 c058cb18 c058ca94 00000000
c07c84b8
1f00: c3b61f5c c3b61f10 c055df64 c058cb08 00000000 c383624c 00000000
00000000
1f20: 00000011 c3b61f60 00000000 00000000 00000001 c38360c0 00000011
c3b61f60
1f40: c38361d0 c38361d0 00000001 c38360b8 c3b61f74 c3b61f60 c0575d38
c073fee0
1f60: c3b61f60 c3b61f60 c3b61f94 c3b61f78 c0575e34 c057574c 0006efdc
000b3a91
1f80: 00000000 00000000 00000000 00000000 00000000 00000058 00000000
c3b61fa8
1fa0: c055dfa0 c0582d24 00000000 00000000 fee1dead 28121969 01234567
00000000
1fc0: 00000000 00000000 00000000 00000058 ffffffff 00000000 40023000
00000000
1fe0: 000af58c bef909c0 0007c3ac 401458e8 60000010 fee1dead 00000000
00000000
Backtrace:
[<c06a2750>] (device_shutdown+0x0/0xac) from [<c0582c78>]
(kernel_restart_prepare+0x2c/0x3c)
 r7:00000000 r6:01234567 r5:28121969 r4:00000000
[<c0582c4c>] (kernel_restart_prepare+0x0/0x3c) from [<c0582cc8>]
(kernel_restart+0x14/0x48)
[<c0582cb4>] (kernel_restart+0x0/0x48) from [<c0582dfc>]
(sys_reboot+0xe8/0x1c8)
 r5:28121969 r4:fee1dead
[<c0582d14>] (sys_reboot+0x0/0x1c8) from [<c055dfa0>]
(ret_fast_syscall+0x0/0x28)
 r7:00000058 r6:00000000 r5:00000000 r4:00000000
Code: e3530000 0a000001 e1a0e00f e12fff13 (e5953010)
---[ end trace e241266cd39eb08e ]---

Thanks,
AWG
